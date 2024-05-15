#
# ~/.bashrc
#

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

alias ls='ls --color=auto'
alias grep='grep --color=auto'
alias vim=nvim
alias vi=nvim
alias rm='rm -i'

export VISUAL=nvim
export EDITOR="$VISUAL"
export PAGER=less
export AUR_PAGER=nvim

bind -m vi-command '"v":ignore'
bind -m vi-command '">":edit-and-execute-command'

export BASH_TEMP_HISTORY_DONT_TOUCH="/tmp/bash$(tty | sed "s/\//_/g").stdout"
> $BASH_TEMP_HISTORY_DONT_TOUCH
touch '/tmp/bash_global.stdout'
__ () { 
    tee $BASH_TEMP_HISTORY_DONT_TOUCH '/tmp/bash_global.stdout';
}
_ () { cat $BASH_TEMP_HISTORY_DONT_TOUCH; }
_+ () { cat '/tmp/bash_global.stdout'; }

#PS1='[\u@\h \W]\$ '
PS1='[\W] \$ '
