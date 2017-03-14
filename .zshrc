export LANG=en_US.UTF-8
export LC_ALL=$LANG
export OUTPUT_CHARSET=utf8

eval "$(direnv hook zsh)"

# screenを自動で起動したい場合は、↓のコメントを外す
# if [[ $STY = '' ]] then screen -xR; fi
# tmuxを自動で起動したい場合は、↓のコメントを外す
# if [[ $TMUX = '' ]] then tmux a || tmux; fi

fpath=(~/.zsh-completions/src ${fpath})
autoload -U compinit && compinit
autoload colors

zstyle ':completion:*' use-cache true
zstyle ':completion:*' matcher-list 'm:{a-z}={A-Z}'
zstyle ':completion:*:default' menu select
zstyle ':completion:*:default' list-colors ${(s.:.)LS_COLORS}

zstyle ':completion:*:sudo:*' command-path /usr/local/sbin /usr/local/bin /usr/sbin /usr/bin /sbin /bin /usr/X11R6/bin


autoload -U colors && colors

# http://mollifier.hatenablog.com/entry/20090814/p1, http://shakenbu.org/yanagi/d/?date=20120306
autoload -Uz vcs_info
zstyle ':vcs_info:*' enable git svn
zstyle ':vcs_info:*' max-exports 3
zstyle ':vcs_info:*' formats '%s:%b ' '%r' '%R'

precmd () {
  LANG=en_US.UTF-8 vcs_info
  psvar=()
  [[ -n ${vcs_info_msg_0_} ]] && psvar[1]="$vcs_info_msg_0_"

  if [[ -z ${vcs_info_msg_1_} ]] || [[ -z ${vcs_info_msg_2_} ]]; then
    psvar[2]=$PWD
  else
    psvar[2]=`echo $vcs_info_msg_2_|sed -e "s#$vcs_info_msg_1_\\$##g"`
    psvar[3]="$vcs_info_msg_1_"
    psvar[4]=`echo $PWD|sed -e "s#^$vcs_info_msg_2_##g"`

    tmux rename-window $vcs_info_msg_1_ > /dev/null 2>&1
  fi

  psvar[5]=`df -h ~/|tail -n 1`
  psvar[5]=`echo "a${psvar[5]}"|awk '{printf"disk use: %s / %s", $3, $2}'`
}

# ホスト毎にホスト名の部分の色を作る http://absolute-area.com/post/6664864690/zsh
local HOSTCOLOR=$'%{[38;5;'"$(printf "%d\n" 0x$(hostname|md5sum|cut -c1-2))"'m%}'
local USERCOLOR=$'%{[38;5;'"$(printf "%d\n" 0x$(echo $USERNAME|md5sum|cut -c1-2))"'m%}'

PROMPT="%{${fg[white]}%}>%{[1;36m%}>%{[0;36m%}> %{${fg[green]}%}%1(v|%1v|)%{${fg[yellow]}%}%2v%U%3v%u%4v%{${reset_color}%}
"
case ${UID} in
0)
  # rootの場合は赤くする
  PROMPT=$PROMPT"%{${fg[red]}%}[%n@%f$HOSTCOLOR%m%{${fg[red]}%}]%{${reset_color}%} "
  ;;
*)
  # root以外の場合は緑
  PROMPT=$PROMPT"%{${fg[green]}%}[$USERCOLOR%n%{${fg[green]}%}@%f$HOSTCOLOR%m%{${fg[green]}%}]%{${reset_color}%} "
  ;;
esac

RPROMPT='%{[1;31m%}%5v%{[0;37m%}'


export GOPATH=$HOME/.go
export PATH=$PATH:$GOPATH/bin
export PATH=$HOME/.composer/vendor/bin:$PATH
export GHQ_ROOT=~/work

export EDITOR=vim
bindkey -e

HISTFILE=~/.zsh_history
HISTSIZE=999999
SAVEHIST=999999
REPORTTIME=2

setopt hist_ignore_all_dups
setopt hist_ignore_dups     # ignore duplication command history list
setopt share_history        # share command history data
setopt hist_save_no_dups
setopt auto_cd
setopt auto_pushd
setopt pushd_ignore_dups
setopt correct
setopt list_packed
setopt complete_aliases
setopt extended_glob
setopt transient_rprompt
setopt prompt_subst

alias grep='grep --color=auto'
alias ls='ls -lhp'
alias less='less -CRSn'
alias vi='vim'
alias curl='curl -s'
alias ghqls='cd $GHQ_ROOT/$(ghq list | peco)'

alias -s zshrc='source'
alias -s php='php'
alias -s py='python'
alias -s rb='ruby'
alias -s jar='java -jar'
alias -s js='node'
alias -s coffee='coffee'
alias -s {tar,tar.gz,tgz}='tar xvf'
alias -s zip='unzip'
alias -s git='git clone'
alias -s sh='/bin/bash'

# npm completion
if [ -x "`which npm`" ]; then; . <(npm completion); fi

# useful functions
function tmpdir() {
  local tmpdirname="tmp_$(date +'%Y%m%d')"
  mkdir -p ~/$tmpdirname
  cd ~/$tmpdirname
}

# for cygwin
cs () { cygstart $1 }
sublime () { cygstart `cygpath -ad /cygdrive/c/Program\ Files/Sublime\ Text\ 3/sublime_text.exe` $1 }

# http://qiita.com/yuyuchu3333/items/e9af05670c95e2cc5b4d
function do_enter() {
    if [ -n "$BUFFER" ]; then
        zle accept-line
        return 0
    fi
    echo
    ls
    # ↓おすすめ
    # ls_abbrev
    if [ "$(git rev-parse --is-inside-work-tree 2> /dev/null)" = 'true' ]; then
        echo
        echo -e "\e[0;33m--- git status ---\e[0m"
        git status -s
    fi
    echo
    zle reset-prompt
    return 0
}
zle -N do_enter
bindkey '^m' do_enter

# ssh-agent の起動及び agent-forward対応
AGENT_SOCK_FILE="/tmp/ssh-agent-$USER"
SSH_AGENT_FILE="$HOME/.ssh-agent-info"
if test $SSH_AUTH_SOCK ; then
  if [ $SSH_AUTH_SOCK != $AGENT_SOCK_FILE ] ; then
    ln -sf $SSH_AUTH_SOCK $AGENT_SOCK_FILE
    export SSH_AUTH_SOCK=$AGENT_SOCK_FILE
  fi
else
  test -f $SSH_AGENT_FILE && source $SSH_AGENT_FILE
  if ! ssh-add -l >& /dev/null ; then
    ssh-agent > $SSH_AGENT_FILE
    source $SSH_AGENT_FILE
    ssh-add
  fi
fi

# ローカル用の設定を読む
if [ -f ~/.zshrc.local ]; then
  source ~/.zshrc.local;
fi

# see http://qiita.com/ysk_1031/items/8cde9ce8b4d0870a129d
function peco_select_history() {
    local tac
    if which tac > /dev/null; then
         tac="tac"
    else
      tac="tail -r"
    fi
    BUFFER=$(fc -l -n 1 | eval $tac | peco --query "$LBUFFER")
    CURSOR=$#BUFFER
    zle clear-screen
}
zle -N peco_select_history
bindkey '^r' peco_select_history

function peco-src () {
    local selected_dir=$GHQ_ROOT/$(ghq list | peco --query "$LBUFFER")
    if [ -n "$selected_dir" ]; then
        BUFFER="cd ${selected_dir}"
        zle accept-line
    fi
    zle clear-screen
}
zle -N peco-src
bindkey '^]' peco-src
