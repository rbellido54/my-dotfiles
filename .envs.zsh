export GPG_TTY=$(tty)
export GPG_TTY

gpg-connect-agent /bye >/dev/null
export SSH_AUTH_SOCK=$(gpgconf --list-dirs agent-ssh-socket)


#[ -f ~/.gnupg/gpg-agent-info ] && source ~/.gnupg/gpg-agent-info
#if [ -S "${GPG_AGENT_INFO%%:*}" ]; then
    #export GPG_AGENT_INFO
#else
    #eval $( gpg-agent --daemon --options ~/.gnupg/gpg-agent.conf --write-env-file ~/.gnupg/gpg-agent-info )
#fi

EDITOR=nvim
