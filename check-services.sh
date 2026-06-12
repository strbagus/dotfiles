#!/usr/bin/env bash

TARGET="mygroup.target"
API_URL="http://192.168.99.108:8055/sendMessage"
CODE="123456"

print_warning() {
    local service="$1"
    local subState="$2"
    local timestamp
    timestamp=$(date "+%Y-%m-%d %H:%M:%S")

    msg=$(printf "⚠️ %s is Down\nstate: %s\ndatetime: %s" "$service" "$subState" "$timestamp")
    encoded_msg=$(printf '%s' "$msg" | jq -sRr @uri)

    curl "${API_URL}?message=${encoded_msg}&code=${CODE}"
    echo "MESSAGE: $encoded_msg"


get_services() {
    systemctl list-dependencies "$TARGET" \
        --plain --no-pager --type=service |
        tail -n +2 |
        xargs |
        jq -r --raw-input '. | split(" ") | .[]'
}

check_service() {
    local service="$1"

    result=$(systemctl show $service \
        -p Id \
        -p Description \
        -p ActiveState \
        -p SubState \
        -p ExecMainPID \
        -p MemoryCurrent \
        -p CPUUsageNSec \
        --no-pager | \
        jq --slurp --raw-input '
        split("\n")
        | map(select(. != "") | split("=") | {"key": .[0], "value": (.[1:] | join("="))})
        | from_entries
        | {
            name: .Id,
            is_active: (.ActiveState=="active"),
            pid: (.ExecMainPID | tonumber),
            memory: (try (.MemoryCurrent | tonumber) catch 0),
            cpu_ns: (try (.CPUUsageNSec | tonumber) catch 0),
            sub_state: .SubState,
            description: .Description
        }'
    )

    is_active=$(echo "$result" | jq -r '.is_active')
    subState=$(echo "$result" | jq -r '.sub_state')

    if [[ "$is_active" != "true" ]]; then
        print_warning "$service" "$subState"
    fi
}

main() {
    while read -r service; do
        check_service "$service"
    done < <(get_services)
}

main
