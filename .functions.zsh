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

# Compression
compress() { tar -czf "${1%/}.tar.gz" "${1%/}"; }
alias decompress="tar -xzf"

# Write iso file to sd card
iso2sd() {
  if [ $# -ne 2 ]; then
    echo "Usage: iso2sd <input_file> <output_device>"
    echo "Example: iso2sd ~/Downloads/ubuntu-25.04-desktop-amd64.iso /dev/sda"
    echo -e "\nAvailable SD cards:"
    lsblk -d -o NAME | grep -E '^sd[a-z]' | awk '{print "/dev/"$1}'
  else
    sudo dd bs=4M status=progress oflag=sync if="$1" of="$2"
    sudo eject $2
  fi
}

# Create a desktop launcher for a web app
web2app() {
  if [ "$#" -ne 3 ]; then
    echo "Usage: web2app <AppName> <AppURL> <IconURL> (IconURL must be in PNG -- use https://dashboardicons.com)"
    return 1
  fi

  local APP_NAME="$1"
  local APP_URL="$2"
  local ICON_URL="$3"
  local ICON_DIR="$HOME/.local/share/applications/icons"
  local DESKTOP_FILE="$HOME/.local/share/applications/${APP_NAME}.desktop"
  local ICON_PATH="${ICON_DIR}/${APP_NAME}.png"

  mkdir -p "$ICON_DIR"

  if ! curl -sL -o "$ICON_PATH" "$ICON_URL"; then
    echo "Error: Failed to download icon."
    return 1
  fi

  cat > "$DESKTOP_FILE" <<EOF
[Desktop Entry]
Version=1.0
Name=$APP_NAME
Comment=$APP_NAME
Exec=chromium --new-window --ozone-platform=wayland --app="$APP_URL" --name="$APP_NAME" --class="$APP_NAME"
Terminal=false
Type=Application
Icon=$ICON_PATH
StartupNotify=true
EOF

  chmod +x "$DESKTOP_FILE"
}

web2app-remove() {
  if [ "$#" -ne 1 ]; then
    echo "Usage: web2app-remove <AppName>"
    return 1
  fi

  local APP_NAME="$1"
  local ICON_DIR="$HOME/.local/share/applications/icons"
  local DESKTOP_FILE="$HOME/.local/share/applications/${APP_NAME}.desktop"
  local ICON_PATH="${ICON_DIR}/${APP_NAME}.png"

  rm "$DESKTOP_FILE"
  rm "$ICON_PATH"
}
