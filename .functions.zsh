# Swaps two windows by shifting all windows in between
swapshift_tmux_windows() {
    if [ $# -ne 2 ]; then
        echo "Usage: swap_tmux_windows <source_window> <target_window>"
        return 1
    fi

    local SOURCE_WINDOW=$1
    local TARGET_WINDOW=$2

    local HIGHEST_WINDOW=$(tmux list-windows | awk -F: '{print $1}' | sort -n | tail -1)

    if [ "$SOURCE_WINDOW" -eq "$TARGET_WINDOW" ]; then
        echo "Source window is already at the target position."
        return 0
    fi

    local TEMP_WINDOW=99
    tmux move-window -s $SOURCE_WINDOW -t $TEMP_WINDOW

    if [ "$SOURCE_WINDOW" -gt "$TARGET_WINDOW" ]; then
        for ((i=$TARGET_WINDOW; i<=$SOURCE_WINDOW-1; i++)); do
            tmux move-window -s $i -t $(($i + 1))
        done
    else
        for ((i=$TARGET_WINDOW-1; i>=$SOURCE_WINDOW; i--)); do
            tmux move-window -s $i -t $(($i - 1))
        done
    fi

    tmux move-window -s $TEMP_WINDOW -t $TARGET_WINDOW

    # Remove if you don't want automatic window renumbering
    tmux set-option -g renumber-windows on
}

which-terminal() {
  local ppid
  ppid=$(ps -o ppid= -p $$)
  ps -o comm= -p "$ppid"
}
