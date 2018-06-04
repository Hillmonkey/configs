# ~/.bashrc: executed by bash(1) for non-login shells.
# see /usr/share/doc/bash/examples/startup-files (in the package bash-doc)
# for examples

# If not running interactively, don't do anything
case $- in
    *i*) ;;
      *) return;;
esac

# don't put duplicate lines or lines starting with space in the history.
# See bash(1) for more options
HISTCONTROL=ignoreboth

# append to the history file, don't overwrite it
shopt -s histappend

# for setting history length see HISTSIZE and HISTFILESIZE in bash(1)
HISTSIZE=1000
HISTFILESIZE=2000

# check the window size after each command and, if necessary,
# update the values of LINES and COLUMNS.
shopt -s checkwinsize

#shopt -s globstar

# make less more friendly for non-text input files, see lesspipe(1)
[ -x /usr/bin/lesspipe ] && eval "$(SHELL=/bin/sh lesspipe)"

# set variable identifying the chroot you work in (used in the prompt below)
if [ -z "${debian_chroot:-}" ] && [ -r /etc/debian_chroot ]; then
    debian_chroot=$(cat /etc/debian_chroot)
fi

# set a fancy prompt (non-color, unless we know we "want" color)
case "$TERM" in
    xterm-color|*-256color) color_prompt=yes;;
esac

# uncomment for a colored prompt, if the terminal has the capability; turned
# off by default to not distract the user: the focus in a terminal window
# should be on the output of commands, not on the prompt
#force_color_prompt=yes

if [ -n "$force_color_prompt" ]; then
    if [ -x /usr/bin/tput ] && tput setaf 1 >&/dev/null; then
	# We have color support; assume it's compliant with Ecma-48
	# (ISO/IEC-6429). (Lack of such support is extremely rare, and such
	# a case would tend to support setf rather than setaf.)
	color_prompt=yes
    else
	color_prompt=
    fi
fi

if [ "$color_prompt" = yes ]; then
    PS1='${debian_chroot:+($debian_chroot)}\[\033[01;32m\]\u@\h\[\033[00m\]:\[\033[01;34m\]\w\[\033[00m\]\$ '
else
    PS1='${debian_chroot:+($debian_chroot)}\u@\h:\w\$ '
fi
unset color_prompt force_color_prompt

# If this is an xterm set the title to user@host:dir
case "$TERM" in
xterm*|rxvt*)
    PS1="\[\e]0;${debian_chroot:+($debian_chroot)}\u@\h: \w\a\]$PS1"
    ;;
*)
    ;;
esac

# enable color support of ls and also add handy aliases
if [ -x /usr/bin/dircolors ]; then
    test -r ~/.dircolors && eval "$(dircolors -b ~/.dircolors)" || eval "$(dircolors -b)"
    alias ls='ls --color=auto'
    #alias dir='dir --color=auto'
    #alias vdir='vdir --color=auto'

    alias grep='grep --color=auto'
    alias fgrep='fgrep --color=auto'
    alias egrep='egrep --color=auto'
fi

# colored GCC warnings and errors
#export GCC_COLORS='error=01;31:warning=01;35:note=01;36:caret=01;32:locus=01:quote=01'

# some more ls aliases
alias ll='ls -alF'
# alias la='ls -A'
alias l='ls -CF'


# Add an "alert" alias for long running commands.  Use like so:
#   sleep 10; alert
alias alert='notify-send --urgency=low -i "$([ $? = 0 ] && echo terminal || echo error)" "$(history|tail -n1|sed -e '\''s/^\s*[0-9]\+\s*//;s/[;&|]\s*alert$//'\'')"'

# Alias definitions.
# You may want to put all your additions into a separate file like
# ~/.bash_aliases, instead of adding them here directly.
# See /usr/share/doc/bash-doc/examples in the bash-doc package.

if [ -f ~/.bash_aliases ]; then
    . ~/.bash_aliases
fi

# enable programmable completion features (you don't need to enable
# this, if it's already enabled in /etc/bash.bashrc and /etc/profile
# sources /etc/bash.bashrc).
if ! shopt -oq posix; then
  if [ -f /usr/share/bash-completion/bash_completion ]; then
    . /usr/share/bash-completion/bash_completion
  elif [ -f /etc/bash_completion ]; then
    . /etc/bash_completion
  fi
fi
git config --global user.name "Larry Madeo"
git config --global user.email "lmadeo76@gmail.com"
git config --global credential.helper 'cache --timeout=86400'
git config --global core.editor "vim"
function parse_git_dirty {
  [[ $(git status 2> /dev/null | tail -n1) != "nothing to commit, working directory clean" ]] && echo "*"
}
function parse_git_branch {
  git branch --no-color 2> /dev/null | sed -e /^[^*]/d -e "s/* \(.*\)/[\1$(parse_git_dirty)]/"
}
export PS1="\[\033[1;30m\]\u \[\033[0;37m\] \[\033[1;32m\]\w\[\033[0m\]\n\[\033[1;31m\]\$(parse_git_branch) \[\033[0m\]\$ "
# Larry uses vim!
VISUAL=vim
EDITOR="$VISUAL"
mkdir -p ~/.vim/colors

# Larrys bashrc
# Larrys extra additions ################################
# Larry's home rolled aliases
alias find-git='find . -d | grep .git$'
alias gzz='gcc -Wall -Wextra -pedantic -g'
alias chpy='chmod 755 *.py'
alias chjs='chmod 755 *.js'
alias chsh='chmod 755 *.sh'
alias myssh_web1='ssh -i ~/.ssh/holberton ubuntu@142.44.167.249'
alias myssh_lb='ssh -i ~/.ssh/holberton ubuntu@144.217.246.148'
alias myssh_web2='ssh -i ~/.ssh/holberton ubuntu@144.217.246.226'
alias servethisfolder='python -m SimpleHTTPServer'
alias mymy='mysql -hlocalhost -uroot -p'
alias vag='vagrant up && vagrant ssh' # add this to repo, later
alias la='ls -ld .[!.]*'
alias testall='python3 -m unittest discover tests'
alias load_bal='144.217.246.148'
alias web1='142.44.167.249'
alias web2='144.217.246.226'
alias semijq='semistandard  --global $ '
alias airbnb='HBNB_MYSQL_USER=hbnb_dev HBNB_MYSQL_PWD=hbnb_dev_pwd HBNB_MYSQL_HOST=localhost HBNB_MYSQL_DB=hbnb_dev_db HBNB_TYPE_STORAGE=db python3 -m ~/AirBnb_clone_v4/web_dynamic.0-hbnb'
# example jsonpp usage: "jsonpp < myfile.json" or "cat myfile.json | jsonpp"
alias jsonpp="python -c 'import sys, json; print json.dumps(json.load(sys.stdin), sort_keys=True, indent=2)'"

complete -C /usr/local/bin/vault vault

# The next line updates PATH for the Google Cloud SDK.
if [ -f '/home/lmadeo/gcloud/google-cloud-sdk/path.bash.inc' ]; then source '/home/lmadeo/gcloud/google-cloud-sdk/path.bash.inc'; fi

# The next line enables shell command completion for gcloud.
if [ -f '/home/lmadeo/gcloud/google-cloud-sdk/completion.bash.inc' ]; then source '/home/lmadeo/gcloud/google-cloud-sdk/completion.bash.inc'; fi
source <(kubectl completion bash)
