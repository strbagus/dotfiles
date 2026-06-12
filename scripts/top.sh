#!/bin/bash

SESSION="top"

# Check if the session already exists
tmux has-session -t $SESSION 2>/dev/null

if [ $? != 0 ]; then
  # 1. Create a new session and start 'btop' in the first pane
  tmux new-session -d -s $SESSION -n "Monitors" "btop"

  # 2. Split horizontally. Adjust '-p 40' to change the right pane's width (%)
  tmux split-window -h -p 40 -t $SESSION "ping google.com"

  # 3. Target the left pane and split it vertically. 
  # Adjust '-p 50' to change the nvtop pane's height (%)
  tmux select-pane -t $SESSION:0.0
  tmux split-window -v -p 30 -t $SESSION "nvtop"

  # 4. Set final focus back to the top-left pane (btop)
  tmux select-pane -t $SESSION:0.0
fi

# Attach to the session
tmux attach-session -t $SESSION
