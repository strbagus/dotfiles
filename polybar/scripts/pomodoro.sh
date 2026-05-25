#!/usr/bin/env bash

PID_FILE="/tmp/polybar_pomodoro_pid"
OUTPUT_FILE="/tmp/polybar_pomodoro_output"

WORK_TIME=$((30 * 60)) # 30 menit kerja
REST_TIME=$((5 * 60)) # 5 menit istirahat

format_time() {
    printf "%02d:%02d" $(( $1 / 60 )) $(( $1 % 60 ))
}

run_timer() {
    while true; do
        notify-send -u critical "Pomodoro" "Waktunya fokus! Sesi kerja 30 menit dimulai."
        for ((i=WORK_TIME; i>0; i--)); do
            echo "󱎫 $(format_time $i)" > "$OUTPUT_FILE"
            sleep 1
        done

        notify-send -u normal "Pomodoro" "Kerja bagus! Rehat dulu 5 menit."
        for ((i=REST_TIME; i>0; i--)); do
            echo "󱄊 $(format_time $i)" > "$OUTPUT_FILE"
            sleep 1
        done
    done
}

if [ "$1" == "--toggle" ]; then
    if [ -f "$PID_FILE" ]; then
        pid=$(cat "$PID_FILE")
        kill "$pid" 2>/dev/null
        rm -f "$PID_FILE" "$OUTPUT_FILE"
        notify-send "Pomodoro" "Timer dihentikan."
    else
        run_timer &
        echo $! > "$PID_FILE"
    fi
else
    if [ -f "$PID_FILE" ] && kill -0 $(cat "$PID_FILE") 2>/dev/null; then
        if [ -f "$OUTPUT_FILE" ]; then
            cat "$OUTPUT_FILE"
        else
            echo "󱎫 Menghitung..."
        fi
    else
        echo "󱎯 Kerja"
    fi
fi
