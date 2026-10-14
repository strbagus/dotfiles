# Add to local.zsh
RPI="rpi"
NOTES_DIR="$HOME/Documents/Notes"
notes() {
    nvim "${NOTES_DIR}"
    {
        if rsync -az --delete-after -e 'ssh -o ConnectTimeout=3' "${NOTES_DIR}" "${RPI}:data" > /dev/null 2>&1; then
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

