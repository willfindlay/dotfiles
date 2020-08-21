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


# Save changed directory as last changed directory
#function cd_ {
#  cd "$@"
#  echo $PWD > ~/.last_dir
#}
#alias cd='cd_'

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

# Limit process execution to three cores
function limit {
    numactl -C 0,1,2 $argv
}

# Like cd but resolves links first
function lcd {
    cd $(readlink -f $argv)
}


# =========================================================================== #
# Environment Variables                                                       #
# =========================================================================== #


# Set editor and browser
export EDITOR=nvim
export BROWSER=firefox

# Append to PATH
export PATH="$PATH:$HOME/.local/bin"
export PATH="$PATH:$(ruby -e 'puts Gem.user_dir')/bin"
export PATH="$PATH:/usr/share/bcc/tools"

# Set display env
export DISPLAY=:0.0

# Set gopath
export GOPATH=$HOME/.local/go

# Pipenv in project folder
export PIPENV_VENV_IN_PROJECT=1

export FZF_DEFAULT_COMMAND='find .'


# =========================================================================== #
# Color support                                                               #
# =========================================================================== #


# zsh syntax highlighting
. /usr/share/zsh/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh

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
alias diff='diff --color'

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
# Hook Functions                                                              #
# =========================================================================== #


# This function sets up the git prompt if we are in a repository,
# otherwise it just unsets it.
# We invoke it before every command so that it updates promptly.
function setup_git_prompt {
    if ! git rev-parse --is-inside-work-tree >/dev/null 2>&1; then
        unset git_prompt
        return 0
    fi

    local git_status git_branch

    git_branch="$(git symbolic-ref HEAD 2>/dev/null)"
    git_branch="${git_branch#refs/heads/}"

    if [ "${#git_branch}" -ge 24 ]; then
        git_branch="${git_branch:0:21}..."
    fi

    git_status=$(git status | (
    unset dirty deleted untracked newfile ahead behind renamed
    while read line ; do
        case "$line" in
          *modified:*)                      dirty='%F{blue}%B+%b%f' ; ;;
          *deleted:*)                       deleted='%F{red}%Bx%b%f' ; ;;
          *'Untracked files:')              untracked='%F{yellow}%B…%b%f' ; ;;
          *'new file:'*)                    newfile='%F{green}%B*%b%f' ; ;;
          *'Your branch is ahead of '*)     ahead='%F{green}%B⬆%b%f' ; ;;
          *'Your branch is behind '*)       behind='%F{blue}%B⬇%b%f' ; ;;
          *renamed:*)                       renamed='%F{magenta}%B>%b%f' ; ;;
        esac
    done
    git_status="$ahead$behind$newfile$deleted$dirty$renamed$untracked"
    [ -n "$git_status" ] && echo "$git_status" || echo '%F{green}✔%f'
    ))

    git_branch="${git_branch:-no branch}"

    git_prompt=" %F{normal}(%f%F{green}%B${git_branch}%b%f ${git_status}%F{normal})%f"
}


# =========================================================================== #
# Prompt                                                                      #
# =========================================================================== #


# If you want powerline, uncomment this and comment everything else
# in this section.
#powerline-daemon -q
#. /usr/lib/python3.8/site-packages/powerline/bindings/zsh/powerline.zsh

# Refresh git prompt before each command
precmd() {
    setup_git_prompt
    export RPS1="$git_prompt"
}

# This long and complex format string produces a sexy prompt
export PS1="%F{8}[%T]%f %(!.%F{1}.%F{4})%n%f%F{8}@%f%(!.%F{1}.%F{4})%m%f%F{8}:%f%F{3}%(!.%d.%~)%f %F{1}|%f "


# =========================================================================== #
# Greeting                                                                    #
# =========================================================================== #

function greeting {
    # TODO
}

greeting

PATH="/home/housedhorse/perl5/bin${PATH:+:${PATH}}"; export PATH;
PERL5LIB="/home/housedhorse/perl5/lib/perl5${PERL5LIB:+:${PERL5LIB}}"; export PERL5LIB;
PERL_LOCAL_LIB_ROOT="/home/housedhorse/perl5${PERL_LOCAL_LIB_ROOT:+:${PERL_LOCAL_LIB_ROOT}}"; export PERL_LOCAL_LIB_ROOT;
PERL_MB_OPT="--install_base \"/home/housedhorse/perl5\""; export PERL_MB_OPT;
PERL_MM_OPT="INSTALL_BASE=/home/housedhorse/perl5"; export PERL_MM_OPT;
