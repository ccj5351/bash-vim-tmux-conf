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

# If set, the pattern "**" used in a pathname expansion context will
# match all files and zero or more directories and subdirectories.
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
alias la='ls -A'
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

# Added by CCJ.
#. /home/ccj/torch/install/bin/torch-activate
#PATH=/usr/local/texlive/2016/bin/i386-linux:$PATH

# virtualenv and virtualenvwrapper
#export VIRTUALENVWRAPPER_PYTHON=/usr/local/bin/python3
#export WORKON_HOME=$HOME/.virtualenvs
#source /usr/local/bin/virtualenvwrapper.sh

#alias matlab="/usr/local/MATLAB/R2015b/bin/matlab"

# tmux color
export TERM="screen-256color"
alias tmux="tmux -2"

# Added by CCJ.
alias clc="clear"
alias lsc="ls -1 | wc -l" # Trying to count number of files in current directory

# Added by CCJ.
#alias link-vision3="ssh -X ccj@vision3.srcit.stevens.edu"
#alias link-vision4="ssh -X ccj@vision4.srcit.stevens.edu"
#alias link-vision5="ssh -X ccj@vision5.srcit.stevens.edu"
alias lv3="ssh -X ccj@vision3.srcit.stevens.edu"
alias lv4="ssh -X ccj@vision4.srcit.stevens.edu"
alias lv5="ssh -X ccj@vision5.srcit.stevens.edu"
alias lv6="ssh -X ccai1@vision6.cs.stevens-tech.edu"
#alias lv3tb="ssh -X -L 16006:vision3.srcit.stevens.edu:6006 ccj@vision3.srcit.stevens.edu"
#alias lv3tb="ssh -X -L 16006:127.0.0.1:6006 ccj@vision3.srcit.stevens.edu"
#alias lv5tb="ssh -X -L 16006:127.0.0.2:6006 ccj@vision5.srcit.stevens.edu"

alias lvkb="ssh -X ccj@155.246.238.138"

# Added by CCJ.
alias mount-vision3="sudo sshfs -o allow_other,IdentityFile=/home/ccj/.ssh/ccj_cv24_id_rsa ccj@vision3.srcit.stevens.edu:/ /mnt/vision3/"
alias mount-vision4="sudo sshfs -o allow_other,IdentityFile=/home/ccj/.ssh/ccj_cv24_id_rsa ccj@vision4.srcit.stevens.edu:/ /mnt/vision4/"
alias mount-vision5="sudo sshfs -o allow_other,IdentityFile=/home/ccj/.ssh/ccj_cv24_id_rsa ccj@vision5.srcit.stevens.edu:/ /mnt/vision5/"
alias mount-vision6="sudo sshfs -o allow_other,IdentityFile=/home/ccj/.ssh/ccj_cv24_id_rsa ccai1@vision6.cs.stevens-tech.edu:/ /mnt/vision6/"

alias umount-vision3="sudo umount /mnt/vision3/"
alias umount-vision4="sudo umount /mnt/vision4/"
alias umount-vision5="sudo umount /mnt/vision5/"
alias umount-vision6="sudo umount /mnt/vision6/"

alias cdv3="cd /mnt/vision3/home/ccj/"
alias cdv4="cd /mnt/vision4/home/ccj/"
alias cdv5="cd /mnt/vision5/home/ccj/"
alias cdv6="cd /mnt/vision6/ccjData/"

# Added by CCJ.
PATH=$TBB_LIBRARY:$PATH
PATH=/usr/local/cuda-8.0/bin${PATH:+:${PATH}}
LD_LIBRARY_PATH=/usr/local/cuda-8.0/lib${LD_LIBRARY_PATH:+:${LD_LIBRARY_PATH}}


LIBRARY_PATH=$LIBRARY_PATH:/usr/local/opencv-3.2.0/lib

# set path to qt libraries, Qt5.2.1 upgrade to Qt5.5 has some issue here 
export LD_LIBRARY_PATH=$LD_LIBRARY_PATH:/usr/local/lib
export LD_LIBRARY_PATH=$LD_LIBRARY_PATH:"/usr/local/Qt/5.7/gcc_64/lib/:/usr/local/Qt/Tools/QtCreator/lib/qtcreator/"

CPLUS_INCLUDE_PATH=/usr/local/opencv-3.2.0/include${CPLUS_INCLUDE_PATH:+:${CPLUS_INCLUDE_PATH}}
C_INCLUDE_PATH=/usr/local/opencv-3.2.0/include${C_INCLUDE_PATH:+:${C_INCLUDE_PATH}}


export CFLAGS="-I /usr/local/lib/python2.7/dist-packages/numpy/core/include $CFLAGS"

#*********************************************************
# see https://github.com/ccj5351/imageutilities
# for ImageUtilities - Bridge the gap between CPU and GPU;
export COMPUTE_CAPABILITY=6.1
export CUDA_SDK_ROOT_DIR=/home/ccj/NVIDIA_CUDA-8.0_Samples/
export IMAGEUTILITIES_ROOT=/home/ccj/cnn-crf-stereo/dependencies/imageutilities/
#*********************************************************

# Nodejs, see https://github.com/nodejs/help/wiki/Installation
export NODEJS_HOME=/usr/local/lib/nodejs/node-v8.11.2/bin
export PATH=$NODEJS_HOME:$PATH

# function to set terminal title
function set-title(){
	if [[ -z "$ORIG" ]]; then
		ORIG=$PS1
	fi
	TITLE="\[\e]2;$*\a\]"
	PS1=${ORIG}${TITLE}
}

export PATH="$PATH:$HOME/bin"
source /home/ccj/.bazel/bin/bazel-complete.bash


alias matlab="/usr/local/MATLAB/R2015b/bin/matlab"
