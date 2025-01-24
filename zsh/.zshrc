# -----------------------------------------------------------------------------
# Env Variables
# -----------------------------------------------------------------------------

export LANG="en_US.UTF-8"
export PATH="${HOME}/.local/bin:/usr/local/bin:${PATH}"
export MANPATH="/usr/local/man:${MANPATH}"
export XDG_CONFIG_HOME="${HOME}/.config"

# -----------------------------------------------------------------------------
# Init oh-my-zsh
# -----------------------------------------------------------------------------

ZSH=${HOME}/.oh-my-zsh
ZSH_THEME="robbyrussell"
plugins=(
    git z cp rust copypath emoji emoji-clock encode64 extract \
    iterm2 pip qrcode rand-quote safe-paste tmux-cssh web-search
)

source ${ZSH}/oh-my-zsh.sh

# iterm
zstyle :omz:plugins:iterm2 shell-integration yes
zstyle ':completion:*' menu select

# -----------------------------------------------------------------------------
# Variables
# -----------------------------------------------------------------------------

# editor
# ------

if `where nvim &> /dev/null`; then
    EDITOR="nvim"
elif `where vim &> /dev/null`; then
    EDITOR="vim"
else
    EDITOR="nano"
fi

# directories
# -----------

loc=${HOME}/.local
opt=${HOME}/.local/opt
lib=${HOME}/.local/lib
bin=${HOME}/.local/bin
jars=${HOME}/.local/lib/jars
config=${XDG_CONFIG_HOME}

# configs
# -------

zshrc=${HOME}/.zshrc
ushrc=${HOME}/.zshrc.$USER
aliasrc=${HOME}/.zshrc.aliases
sshrc=${HOME}/.ssh
vimrc=${HOME}/.vimrc
gitrc=${config}/git/config
nvimrc=${config}/nvim
tmuxrc=${config}/tmux/tmux.conf

# -----------------------------------------------------------------------------
# Aliases
# -----------------------------------------------------------------------------

# common
alias v="${EDITOR}"
alias so="source"
alias ls="gls --color=tty"
alias echo="gecho"
alias tar="gtar"
alias edit="${EDITOR}"
alias which-command='whence'

# ls
alias l="gls --color=tty -lh --group-directories-first"
alias la="gls --color=tty -lAh --group-directories-first"
alias ll="gls --color=tty -lah --group-directories-first"

# apt
alias aptfull="sudo apt-get update && sudo apt full-upgrade"
alias aptupdate="sudo apt-get update"
alias aptinstall="sudo apt-get install"
alias aptupstall="sudo apt-get update && sudo apt-get install"
alias aptupgrade="sudo apt-get update && sudo apt upgrade"

# configs
alias zshrc="v ${zshrc}"
alias ushrc="v ${ushrc}"
alias aliasrc="v ${aliasrc}"
alias sshrc="v ${sshrc}"
alias gitrc="v ${gitrc}"
alias vimrc="v ${vimrc}"
alias nvimrc="v ${nvimrc}"
alias tmuxrc="v ${tmuxrc}"

# -----------------------------------------------------------------------------
# Functions
# -----------------------------------------------------------------------------

function search() {
    if [ -n "$1" ] && [ -n "$2" ]
    then
        ll "$2" | grep "$1"
    elif [ -n "$1" ]
    then
        ll . | grep "$1"
    else
        echo "Usage: $0 <search-expr> [search-path]"
    fi
}

# -----------------------------------------------------------------------------
# Shell Completions
# -----------------------------------------------------------------------------

source $HOME/.oh-my-zsh/completions/_doing.zsh

# -----------------------------------------------------------------------------
# Auto Generated Tool Configs
# -----------------------------------------------------------------------------

source $HOME/.zshrc.tools

# -----------------------------------------------------------------------------
# User Configs
# -----------------------------------------------------------------------------

source $HOME/.zshrc.$USER
source $HOME/.zshrc.aliases

