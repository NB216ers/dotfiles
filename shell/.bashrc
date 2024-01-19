# exec zsh -l

#THIS MUST BE AT THE END OF THE FILE FOR SDKMAN TO WORK!!!
export SDKMAN_DIR="$HOME/.sdkman"
[[ -s "$HOME/.sdkman/bin/sdkman-init.sh" ]] && source "$HOME/.sdkman/bin/sdkman-init.sh"
#config proxy
#export http_proxy="127.0.0.1:10809"
#export https_proxy="127.0.0.1:10809"
eval "$(starship init bash)"

# https://github.com/alacritty/alacritty/issues/1687
tmux () {
    TMUX="command tmux ${@}"
#    SHELL=/usr/bin/bash script -qO /dev/null -c "eval $TMUX";
    SHELL=C:\\tools\\msys64\\usr\\bin\\bash.exe script -qO /dev/null -c "eval $TMUX";
}

# Aliases
if [ -f ~/.alias ]; then
	. ~/.alias
fi

# You can bind the up and down arrow keys to search through Bash's history(https://wiki.archlinux.org/title/Bash#History_completion)
bind '"\e[A": history-search-backward'
bind '"\e[B": history-search-forward'

# export FZF_COMPLETION_TRIGGER='~~'

# tldr("To long don`t read"),简化的 man page http://tldr-pages.github.io/
# tldr 

# Go
export GOROOT=/mingw64/lib/go
export GOPATH=$HOME/go
export PATH=$PATH:$GOROOT/bin:$GOPATH/bin
########################### JUMP ###########################
eval "$(jump shell)"

__jump_chpwd() {
  jump chdir
}

jump_completion() {
  reply="'$(jump hint "$@")'"
}

j() {
  local dir="$(jump cd $@)"
  test -d "$dir" && cd "$dir"
}

#typeset -gaU chpwd_functions
#chpwd_functions+=__jump_chpwd

#compctl -U -K jump_completion j
########################## 🔼 JUMP 🔼 ##########################


########################## 🔽 SHORTCUTS 🔽 ###########################
lfcd () {
    tmp="$(mktemp)"
    lf -last-dir-path="$tmp" "$@"
    if [ -f "$tmp" ]; then
        dir="$(cat "$tmp")"
        rm -f "$tmp"
        [ -d "$dir" ] && [ "$dir" != "$(pwd)" ] && cd "$dir"
    fi
}

#bind -x '"\C-o": lfcd'

########################## 🔼 SHORTCUTS 🔼 ##########################

########################## 🔼 FZF 🔼 ##########################

# Use ~~ as the trigger sequence instead of the default **
export FZF_COMPLETION_TRIGGER='~~'

# Options to fzf command
export FZF_COMPLETION_OPTS='--border --info=inline'

# Use fd (https://github.com/sharkdp/fd) instead of the default find
# command for listing path candidates.
# - The first argument to the function ($1) is the base path to start traversal
# - See the source code (completion.{bash,zsh}) for the details.
_fzf_compgen_path() {
  fd --hidden --follow --exclude ".git" . "$1"
}

# Use fd to generate the list for directory completion
_fzf_compgen_dir() {
  fd --type d --hidden --follow --exclude ".git" . "$1"
}

# Advanced customization of fzf options via _fzf_comprun function
# - The first argument to the function is the name of the command.
# - You should make sure to pass the rest of the arguments to fzf.
_fzf_comprun() {
  local command=$1
  shift

  case "$command" in
    cd)           fzf --preview 'tree -C {} | head -200'   "$@" ;;
    export|unset) fzf --preview "eval 'echo \$'{}"         "$@" ;;
    ssh)          fzf --preview 'dig {}'                   "$@" ;;
    *)            fzf --preview 'bat -n --color=always {}' "$@" ;;
  esac
}
########################## 🔼 FZF 🔼 ##########################

# 启动默认使用zsh
#if [ -t 1 ]; then
#    exec zsh
#fi


######################### shell_gpt ###################
export CFLAGS="-I/usr/include"
export LDFLAGS="-L/usr/lib"
export PKG_CONFIG_PATH="/usr/lib/pkgconfig"


[ -f ~/.inshellisense/key-bindings.bash ] && source ~/.inshellisense/key-bindings.bash
