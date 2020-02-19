# Lines configured by zsh-newuser-install

HISTFILE=~/.histfile
HISTSIZE=1000
SAVEHIST=1000
unsetopt beep

# Basic auto/tab complete:
autoload -U compinit
zstyle ':completion:*' matcher-list '' 'm:{a-z}={A-Z}' '+m:{A-Z}={a-z}' #case insensitive globbing
#zstyle ':completion:*' menu select
zmodload zsh/complist
compinit
_comp_options+=(globdots)		# Include hidden files.

# vi mode
bindkey -v
export KEYTIMEOUT=1

# Use vim keys in tab complete menu:
bindkey -M menuselect 'h' vi-backward-char
bindkey -M menuselect 'k' vi-up-line-or-history
bindkey -M menuselect 'l' vi-forward-char
bindkey -M menuselect 'j' vi-down-line-or-history
bindkey -v '^?' backward-delete-char

# Change cursor shape for different vi modes.
function zle-keymap-select {
  if [[ ${KEYMAP} == vicmd ]] ||
     [[ $1 = 'block' ]]; then
    echo -ne '\e[1 q'
  elif [[ ${KEYMAP} == main ]] ||
       [[ ${KEYMAP} == viins ]] ||
       [[ ${KEYMAP} = '' ]] ||
       [[ $1 = 'beam' ]]; then
    echo -ne '\e[5 q'
  fi
}
zle -N zle-keymap-select
zle-line-init() {
    zle -K viins # initiate `vi insert` as keymap (can be removed if `bindkey -V` has been set elsewhere)
    echo -ne "\e[5 q"
}
zle -N zle-line-init
echo -ne '\e[5 q' # Use beam shape cursor on startup.
preexec() { echo -ne '\e[5 q' ;} # Use beam shape cursor for each new prompt.

# Edit line in vim with ctrl-e:
autoload edit-command-line; zle -N edit-command-line
bindkey '^e' edit-command-line

# Environment's variables
export GOPATH="/home/vgaleksa/go"
export VI_MODE="INSERT"

zmodload zsh/datetime

function preexec() {
  __TIMER=$EPOCHREALTIME
}

function powerline_precmd() {
}

function powerline_precmd() {
  local __ERRCODE=$?
  local __DURATION=0

  if [ -n $__TIMER ]; then
    local __ERT=$EPOCHREALTIME
    __DURATION="$(($__ERT - ${__TIMER:-__ERT}))"
  fi

  eval "$($GOPATH/bin/powerline-go \
	  -modules ssh,perms,venv,vgo,cwd -duration \
	  $__DURATION -error $? -shell zsh -eval \
	  -modules-right exit,duration,git,node,time \
	  )"
  unset __TIMER
}

function install_powerline_precmd() {
  for s in "${precmd_functions[@]}"; do
    if [ "$s" = "powerline_precmd" ]; then
      return
    fi
  done
  precmd_functions+=(powerline_precmd)
}

if [ "$TERM" != "linux" ]; then
	preexec
    install_powerline_precmd
fi

alias rb="sudo reboot"
alias sd="sudo shutdown now"
alias pi="sudo pacman -S"
alias pu="sudo pacman -Syu"
alias pf="sudo pacman -Ss"
alias sp="sudo pacman"
alias yu="yay -Syu -a"
alias y="yay"
alias ls="ls --color=auto"
alias la="ls -a"
alias ll="ls -al"
alias vim="nvim"
alias 'v.'='nvim .l'
alias py='python'

LFCD="$GOPATH/src/github.com/gokcehan/lf/etc/lfcd.sh"  # source
LFCD="~/.config/lf/lfcd.sh"                            # pre-built binary
if [ -f "$LFCD" ]; then
    source "$LFCD"
fi

source $HOME/.config/zsh/zsh-autosuggestions/zsh-autosuggestions.zsh
source $HOME/.config/zsh/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
source /home/vgaleksa/.config/zsh/colored_man_pages.zsh


[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh
alias config='/usr/bin/git --git-dir=/home/vgaleksa/.cfg/ --work-tree=/home/vgaleksa'
