# Set complete path
if [[ "$OSTYPE" == "darwin"* ]]; then
  export PKG_CONFIG_PATH="/opt/homebrew/opt/libpq/lib/pkgconfig"
  export PATH="/opt/homebrew/opt/libpq/bin:$PATH"
  export PATH="$HOME/go/bin:$PATH"
else
  export PATH="./bin:$HOME/.local/bin:$HOME/.local/share/omarchy/bin:$PATH"
fi
set +h

export SSH_AUTH_SOCK="$XDG_RUNTIME_DIR/ssh-agent.socket"

# Omarchy path
export OMARCHY_PATH="/home/$USER/.local/share/omarchy"
