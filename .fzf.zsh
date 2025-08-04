# Setup fzf
# ---------
if [[ ! "$PATH" == */opt/homebrew/opt/fzf/bin* ]]; then
  PATH="${PATH:+${PATH}:}/opt/homebrew/opt/fzf/bin"
fi

if [[ "$OSTYPE" == "darwin"* ]]; then
  FZF_PATH="/opt/homebrew/opt/fzf/shell"
elif [[ "$OSTYPE" == "linux-gnu"* ]]; then
  FZF_PATH="/usr/share/fzf"
else
  FZF_PATH="/opt/homebrew/opt/fzf/shell"
fi

if [[ ! "$PATH" == *"${FZF_PATH}/bin"* ]]; then
  PATH="${PATH:+${PATH}:}${FZF_PATH}/bin"
fi

if command -v fzf &> /dev/null; then
  # Auto-completion
  # ---------------
  if [[ -f "${FZF_PATH}/completion.zsh" ]]; then
    source "${FZF_PATH}/completion.zsh"
  else
    echo "Warning: fzf completion file not found at ${FZF_PATH}/completion.zsh"
  fi

  # Key bindings
  # ------------
  if [[ -f "${FZF_PATH}/key-bindings.zsh" ]]; then
    source "${FZF_PATH}/key-bindings.zsh"
  else
    echo "Warning: fzf key bindings file not found at ${FZF_PATH}/key-bindings.zsh"
  fi
fi
