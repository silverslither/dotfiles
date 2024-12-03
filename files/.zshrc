[[ -o interactive ]] || return

HISTFILE=~/.zsh_history
HISTSIZE=1000
SAVEHIST=1000

zstyle ':completion:*' menu select
zstyle ':completion"*' completer _complete _approximate
zstyle ':completion:*' matcher-list 'm:{a-z}={A-Za-z}'
autoload -Uz compinit
compinit

bindkey -v
export KEYTIMEOUT=5

function zle-keymap-select() {
    if [[ $KEYMAP == "vicmd" ]]
    then
        if [[ $TERM == "linux" ]]
        then
            print -n -- "\e[?6c"
        else
            print -n -- "\e[2 q"
        fi
    else
        if [[ $TERM == "linux" ]]
        then
            print -n -- "\e[?0c"
        else
            print -n -- "\e[6 q"
        fi
    fi
}
function zle-line-init() {
    if [[ $TERM == "linux" ]]
    then
        print -n -- "\e[?0c"
    else
        print -n -- "\e[6 q"
    fi
}
zle -N zle-keymap-select
zle -N zle-line-init

function chpwd() { # OSC 7
    emulate -L zsh
    setopt extendedglob
    local LC_ALL=C
    printf "\e]7;file://%s%s\e\\" $HOST ${PWD//(#m)([^@-Za-z&-;_~])/%${(l:2::0:)$(([##16]#MATCH))}}
}
function precmd() {
    print -n -- "\e]133;A\e\\" # prompt jumping
    print -Pn -- "\e]0;zsh: %(1j,%j job%(2j|s|); ,)%~\e\\"
    if ! builtin zle
    then
        print -n -- "\e]133;D\e\\" # pipe-command-output
    fi
}
function preexec() {
    print -n -- "\e]0;${(q)1}\e\\"
    print -n -- "\e]133;C\e\\" # pipe-command-output
}

bindkey -v '^?' backward-delete-char
bindkey '^r' history-incremental-search-backward

function set-vi-colemak() {
    bindkey -a "n" down-line-or-history
    bindkey -a "N" vi-join
    bindkey -a "k" vi-repeat-search
    bindkey -a "K" vi-rev-repeat-search
    bindkey -a "e" up-line-or-history
    bindkey -ar "E"
    bindkey -a "j" vi-forward-word-end
    bindkey -a "J" vi-forward-blank-word-end
    bindkey -a "i" vi-forward-char
    bindkey -ar "I"
    bindkey -a "l" vi-insert
    bindkey -a "L" vi-insert-bol
}

function set-vi-qwerty() {
    bindkey -a "j" down-line-or-history
    bindkey -a "J" vi-join
    bindkey -a "n" vi-repeat-search
    bindkey -a "N" vi-rev-repeat-search
    bindkey -a "k" up-line-or-history
    bindkey -ar "K"
    bindkey -a "e" vi-forward-word-end
    bindkey -a "E" vi-forward-blank-word-end
    bindkey -a "l" vi-forward-char
    bindkey -ar "L"
    bindkey -a "i" vi-insert
    bindkey -a "I" vi-insert-bol
}

if [[ $XDG_CURRENT_DESKTOP == "KDE" ]]
then
    KEYBOARD_LAYOUT=$(qdbus --literal org.kde.keyboard /Layouts getLayoutsList | grep -oP ' \(sss\) \K[^]]*"' | sed -n $(expr $(qdbus --literal org.kde.keyboard /Layouts getLayout) + 1)p)
elif [[ $XDG_CURRENT_DESKTOP == "Hyprland" ]]
then
    KEYBOARD_LAYOUT=$(hyprctl devices | grep at-translated-set-2-keyboard -A 2 | tail -n 1)
fi

if [[ $KEYBOARD_LAYOUT =~ "Colemak" ]]
then
    set-vi-colemak
fi

stty -ixon # disable suspending output

alias ls='ls --color=auto'
alias grep='grep --color=auto'
alias rm='rm -i'
alias cc=clang
alias c++=clang++
alias fzf='fzf -i --bind "tab:toggle-up,btab:toggle-down"'

alias create-venv='python -m venv venv'
alias source-venv='source venv/bin/activate'

alias http='python -m http.server'

export VISUAL=/usr/bin/nvim
export EDITOR=$VISUAL
export PAGER=/usr/bin/less
export AUR_PAGER=/usr/bin/nvim
export MANPAGER='/usr/bin/nvim "+set scl=no" "+Man!"'
export CC=/usr/bin/clang
export CXX=/usr/bin/clang++

function e() {
    local fzf_path
    fzf_path=$(fzf) && $VISUAL "$fzf_path"
}

function d() {
    local fzf_path
    fzf_path=$(fzf --sync --walker dir,follow,hidden) && cd "$fzf_path"
}

ZSH_TEMP_DIR="/run/user/$(id -u)/zsh"
ZSH_TTY_HISTORY="$ZSH_TEMP_DIR/zsh$(/usr/bin/tty | /usr/bin/sed "s/\//_/g").stdout"
ZSH_GLOBAL_HISTORY="$ZSH_TEMP_DIR/zsh_global.stdout"

/usr/bin/mkdir -p $ZSH_TEMP_DIR
:> $ZSH_TTY_HISTORY
/usr/bin/touch $ZSH_GLOBAL_HISTORY

__ () { /usr/bin/tee $ZSH_TTY_HISTORY $ZSH_GLOBAL_HISTORY; }
_ () { /usr/bin/cat $ZSH_TTY_HISTORY; }
_+ () { /usr/bin/cat $ZSH_GLOBAL_HISTORY; }

PROMPT='[%1~] $ '

. "/home/slither/.deno/env"
