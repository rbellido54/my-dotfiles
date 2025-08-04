alias reload_zshrc="exec zsh"

alias -g grep="egrep"
alias -g cat="bat"

if [[ "$OSTYPE" == "darwin"* ]]; then
    command -v /Applications/Tailscale.app/Contents/MacOS/Tailscale >/dev/null 2>&1 && alias tailscale="/Applications/Tailscale.app/Contents/MacOS/Tailscale"
elif [[ "$OSTYPE" == "linux-gnu"* ]]; then
    command -v tailscale >/dev/null 2>&1 && alias tailscale="tailscale"
fi

# File system
alias ls='eza -lh --group-directories-first --icons=auto'
alias lsa='ls -a'
alias lt='eza --tree --level=2 --long --icons --git'
alias lta='lt -a'
alias ff="fzf --preview 'bat --style=numbers --color=always {}'"
alias cd="zd"
zd() {
  if [ $# -eq 0 ]; then
    builtin cd ~ && return
  elif [ -d "$1" ]; then
    builtin cd "$1"
  else
    z "$@" && printf " \U000F17A9 " && pwd || echo "Error: Directory not found"
  fi
}
open() {
  xdg-open "$@" >/dev/null 2>&1 &
}

# Tools
alias g='git'
alias d='docker'
alias r='rails'
n() { if [ "$#" -eq 0 ]; then nvim .; else nvim "$@"; fi; }
alias vim="nvim"

# Find packages without leaving the terminal
alias yayf="yay -Slq | fzf --multi --preview 'yay -Sii {1}' --preview-window=down:75% | xargs -ro yay -S"
