# =========================================================================== #
#                       _________ _        _  _     _______                   #
#              |\     /|\__   __/( \      ( \( )   (  ____ \                  #
#              | )   ( |   ) (   | (      | (|/    | (    \/                  #
#              | | _ | |   | |   | |      | |      | (_____                   #
#              | |( )| |   | |   | |      | |      (_____  )                  #
#              | || || |   | |   | |      | |            ) |                  #
#              | () () |___) (___| (____/\| (____/\/\____) |                  #
#              (_______)\_______/(_______/(_______/\_______)                  #
#                                                                             #
#                  _______  _______           _______  _______                #
#                 / ___   )(  ____ \|\     /|(  ____ )(  ____ \               #
#                 \/   )  || (    \/| )   ( || (    )|| (    \/               #
#                     /   )| (_____ | (___) || (____)|| |                     #
#                    /   / (_____  )|  ___  ||     __)| |                     #
#                   /   /        ) || (   ) || (\ (   | |                     #
#               _  /   (_/\/\____) || )   ( || ) \ \__| (____/\               #
#              (_)(_______/\_______)|/     \||/   \__/(_______/               #
#                                                                             #
#              Author:           William Findlay                              #
#              Email:            william@williamfindlay.com                   #
#              Last Modified:    05/16/20                                     #
#              License:          GPLv3                                        #
#                                                                             #
# =========================================================================== #


# =========================================================================== #
# Preamble                                                                    #
# =========================================================================== #


# Lines configured by zsh-newuser-install
HISTFILE=$HOME/.histfile
HISTSIZE=1000
SAVEHIST=1000
setopt appendhistory autocd extendedglob nomatch notify
unsetopt beep
bindkey -e
# End of lines configured by zsh-newuser-install
# The following lines were added by compinstall
zstyle :compinstall filename $HOME/.zshrc

autoload -Uz compinit
compinit
# End of lines added by compinstall


# =========================================================================== #
# Keybindings                                                                 #
# =========================================================================== #


# Ctrl-arrow keys
bindkey "^[[1;5C" forward-word
bindkey "^[[1;5D" backward-word

# Backspace
bindkey "^[[3~" delete-char

# Fix weird ctrl u behavior
bindkey "^U" backward-kill-line

# No tab characters ree
zstyle ':completion:*' insert-tab false

# Reverse tab menu complete
bindkey '^[[Z' reverse-menu-complete

# Disable ctrl s
stty -ixon


# =========================================================================== #
# Aliases                                                                     #
# =========================================================================== #


# Carleton VPN for access to OpenStack clusters
alias cuvpn='sudo openconnect -u $CARLETON_ID --protocol=anyconnect cuvpn.carleton.ca'

# Python3 default
alias python='python3'
alias pip='pip3'

# Makefiles
alias m='make'

alias bc='bc -l'

# Map vim to nvim if it exists
if command -v nvim > /dev/null
then
    alias vim='nvim'
    alias vi='vim'
    alias v='vim'
fi

# Map ls to exa if it exists
if command -v exa > /dev/null
then
    alias l='exa'
    alias ls='exa'
    alias ll='exa -la'
    alias la='exa -A'
else
    # Add color support to ls if we need it
    alias ls='ls --color=auto'
    alias l='ls'
    alias ll='ls -la'
fi

# Map grep to ripgrep if it exists
if command -v rg > /dev/null
then
    alias grep='rg'
fi

# R convenience
alias r='R'
alias rscript='Rscript'

# Scrot for screenshots
alias scrot='scrot ~/pictures/screenshots/%m-%d_%H:%M:%S.png $ARGS'

# Better sudo
alias sudo='sudo '

# Stupid perf trace ugh
alias trace='/usr/share/bcc/tools/trace'

# Some of Jon Gjengset's aliases from his fish configs:
alias o='xdg-open'
alias g='git'
alias gc='git checkout'
alias ga='git add -p'
alias gah='git stash && git pull --rebase && git stash pop'
alias yr='cal -y'
alias rc='source $HOME/.zshrc'

# rlwrap
if command -v rlwrap > /dev/null
then
    alias scheme='rlwrap -r -c -f $HOME/.cache/mit_scheme_bindings.txt scheme'
fi

# Vbox aliases
alias vbox='VBoxManage'

# Run processes detached
alias firefox='run_detached firefox'
alias zathura='run_detached zathura'
alias draw.io='run_detached draw.io'
alias drawio='run_detached draw.io'
alias libreoffice='run_detached libreoffice'

# =========================================================================== #
# Functions                                                                   #
# =========================================================================== #


# Run a command detached from the terminal session
function run_detached {
    nohup $argv </dev/null &>/dev/null & disown
}

# Navigate to top level of git repo
function gr {
    if ! git status &>/dev/null
    then
        echo 1>&2 "$(pwd) is not in a git repository."
        return
    fi
    while test $PWD != "/"
    do
        if test -d .git
        then
            break
        fi
        cd ..
    done
}

# Limit process execution to two cores
function limit {
    numactl -C 0,1 $argv
}

# Like cd but resolves links first
function lcd {
    cd $(readlink -f $argv)
}

function vmlinux {
    bpftool btf dump file /sys/kernel/btf/vmlinux format c
}

function crop-image {
    convert $1 -trim +repage $1
}

# Convert a LaTeX file into plaintext and copy it to the system clipboard
function grammarly {
    detex -l "$1" | sed 's/ *\([ \.,;\:]\)/\1/g' | xclip -selection clipboard
}

function pdftotext {
    command pdftotext "$1" - "${@:2}" | awk '/^$/ { print "\n"; } /./ { printf("%s ", $0); } END { print ""; }' | xclip -selection clipboard
}


# =========================================================================== #
# Environment Variables                                                       #
# =========================================================================== #


# Set editor and browser
export EDITOR=nvim

# Set display env
#export DISPLAY=:0.0

# Set gopath
export GOPATH=$HOME/.local/go

# Pipenv in project folder
export PIPENV_VENV_IN_PROJECT=1

export FZF_DEFAULT_COMMAND='find .'

export NAME="William Findlay"
export EMAIL="william@williamfindlay.com"

export TERM=alacritty

export CARLETON_ID=williamfindlay

# Globals
export TZ="Canada/Eastern"

# Configs
export R_LIBS_USER="$HOME/.Rpackages"
export SXHKD_SHELL=/usr/bin/bash

# Rust stuff
export CARGO_INCREMENTAL=1
export RUSTFLAGS="-C target-cpu=native"
export RUST_BACKTRACE=1

# Handy for debugging
export WINEDEBUG=fixme-all

# make less better
# X = leave content on-screen
# F = quit automatically if less than one screenfull
# R = raw terminal characters (fixes git diff)
#     see http://jugglingbits.wordpress.com/2010/03/24/a-better-less-playing-nice-with-git/
export LESS="-F -X -R"


# =========================================================================== #
# Color support                                                               #
# =========================================================================== #


# zsh syntax highlighting
SYNFILE=/usr/share/zsh/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
[ -f $SYNFILE ] && . $SYNFILE

alias vimdiff='nvim -d'
alias vdiff='nvim -d'

# grep and cousins
#alias grep='grep --color=auto'
#alias fgrep='fgrep --color=auto'
#alias egrep='egrep --color=auto'

# dmesg
alias dmesg='dmesg --color=always'

# less
alias less='less -R'

# diff
alias diff='diff -c --color'

# gcc
export GCC_COLORS='error=01;31:warning=01;35:note=01;36:caret=01;32:locus=01:quote=01'

# exa-specific
# user permission bits
export EXA_COLORS=$EXA_COLORS:"ur=38;5;1:uw=38;5;1:ux=38;5;1:ue=38;5;1"
# group permission bits
export EXA_COLORS=$EXA_COLORS:"gr=38;5;4:gw=38;5;4:gx=38;5;4:ge=38;5;4"
# other permission bits
export EXA_COLORS=$EXA_COLORS:"tr=38;5;5:tw=38;5;5:tx=38;5;5:te=38;5;5"
# TODO: more custom colors! ANSI is soooooo annoying though :(

# man
# NOTE: set this last so that it doesn't mess with env output
export LESS_TERMCAP_mb=$(tput bold; tput setaf 2) # green
export LESS_TERMCAP_md=$(tput bold; tput setaf 6) # cyan
export LESS_TERMCAP_me=$(tput sgr0)
export LESS_TERMCAP_so=$(tput bold; tput setaf 0; tput setab 7) # yellow on blue
export LESS_TERMCAP_se=$(tput rmso; tput sgr0)
export LESS_TERMCAP_us=$(tput smul; tput bold; tput setaf 7) # white
export LESS_TERMCAP_ue=$(tput rmul; tput sgr0)
export LESS_TERMCAP_mr=$(tput rev)
export LESS_TERMCAP_mh=$(tput dim)
export LESS_TERMCAP_ZN=$(tput ssubm)
export LESS_TERMCAP_ZV=$(tput rsubm)
export LESS_TERMCAP_ZO=$(tput ssupm)
export LESS_TERMCAP_ZW=$(tput rsupm)


# =========================================================================== #
# Prompt                                                                      #
# =========================================================================== #


[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh
if command -v starship > /dev/null
then
    eval "$(starship init zsh)"
fi


# =========================================================================== #
# Greeting                                                                    #
# =========================================================================== #


function greeting {
    # TODO
}

greeting
