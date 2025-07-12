alias vim="nvim"
alias n="nvim"
alias reload_zshrc="exec zsh"

alias -g grep="egrep"
alias -g cat="bat"

if [[ "$OSTYPE" == "darwin"* ]]; then
    command -v /Applications/Tailscale.app/Contents/MacOS/Tailscale >/dev/null 2>&1 && alias tailscale="/Applications/Tailscale.app/Contents/MacOS/Tailscale"
elif [[ "$OSTYPE" == "linux-gnu"* ]]; then
    command -v tailscale >/dev/null 2>&1 && alias tailscale="tailscale"
fi
