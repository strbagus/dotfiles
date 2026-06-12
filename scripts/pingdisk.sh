#!/bin/sh

hostname=$(hostname)
disk=$(df -B1 / | tail -1 | awk '{printf "{ \"filesystem\": \"%s\", \"size\": %s, \"used\": %s, \"available\": %s, \"usage\": \"%s\", \"mountpoint\": \"%s\" }\n", $1, $2, $3, $4, $5, $6}')
json=$(echo "$disk" | jq --arg hostname "$hostname" '.hostname = $hostname')
echo "$json"
curl -X POST \
	--url http://localhost:8091/ping/disk \
  -H "Content-Type: application/json" \
  -d "$json"
