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
alias cc=clang
alias c++=clang++

alias create-venv='python -m venv venv'
alias source-venv='source venv/bin/activate'

export VISUAL=/usr/bin/nvim
export EDITOR="$VISUAL"
export PAGER=/usr/bin/less
export AUR_PAGER=/usr/bin/nvim
export CC=/usr/bin/clang
export CXX=/usr/bin/clang++

bind -m vi-command '"v":ignore'
bind -m vi-command '">":edit-and-execute-command'

KEYBOARD_LAYOUT=$(qdbus --literal org.kde.keyboard /Layouts getLayoutsList | grep -oP ' \(sss\) \K[^]]*"' | sed -n $(expr $(qdbus --literal org.kde.keyboard /Layouts getLayout) + 1)p)
if [[ $KEYBOARD_LAYOUT =~ "Colemak" ]]
then
    bind -f "$HOME/.colemak.inputrc"
fi

viman () {
    err=$(/usr/bin/man $1 2>&1 1>/dev/null)
    if [[ $? == 0 ]]
    then
        /usr/bin/nvim -c "set scl=no" -c "hide Man $1"
    else
        /usr/bin/echo "$err" 1>&2
    fi
}

e () {
    path=$(/usr/bin/fzf) && $VISUAL "$path"
}

d () {
    path=$(/usr/bin/fzf --walker dir,follow,hidden) && cd "$path"
}

export BASH_TEMP_HISTORY_DONT_TOUCH="/tmp/bash$(/usr/bin/tty | /usr/bin/sed "s/\//_/g").stdout"
> $BASH_TEMP_HISTORY_DONT_TOUCH
/usr/bin/touch '/tmp/bash_global.stdout'
__ () { 
    /usr/bin/tee $BASH_TEMP_HISTORY_DONT_TOUCH '/tmp/bash_global.stdout';
}
_ () { /usr/bin/cat $BASH_TEMP_HISTORY_DONT_TOUCH; }
_+ () { /usr/bin/cat '/tmp/bash_global.stdout'; }

#PS1='[\u@\h \W]\$ '
PS1='[\W] \$ '
