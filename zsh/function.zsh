# Add to local.zsh
# RPI="server.domain.com"
# NOTES_DIR="$HOME/path/to/notes"
notes() {
#    {
#        if ping -c 1 -W 1 ${RPI} > /dev/null 2>&1; then
#            plnote > /dev/null 2>&1 && \
#            notify-send "Notes" "Pull success"
#        else
#            notify-send "Notes" "RPi offline: Local only"
#        fi
#    } &!
    nvim ${NOTES_DIR}
    {
        if ping -c 1 -W 1 ${RPI} > /dev/null 2>&1; then
            psnote > /dev/null 2>&1 && \
            notify-send "Notes" "Push success"
        else
            notify-send "Notes" "Offline: Push failed"
        fi
    } &!
}

nn() {
    local TIMESTAMP=$(date +"%y%m%d_%H%M")
    local NAME="${1:-$TIMESTAMP}"
    local FULL_PATH="$NOTES_DIR/${NAME}.md"

    nvim -c "cd $NOTES_DIR" "$FULL_PATH"
}
