export LANG=ja_JP.UTF-8
export OUTPUT_CHARSET=utf8

fpath=(~/.zsh/functions/Completion ${fpath})
autoload -U compinit
compinit

case ${UID} in
0)
	PROMPT="%{[31m%}[%n@%m]%{[m%} "
	;;
*)
	#if [[ $STY = '' ]] then screen -xR; fi
	#PROMPT="# "
	PROMPT="%{[32m%}[%n@%m]%{[m%} "
	;;
esac
RPROMPT="%{[33m%}[%~]%{[m%}"

export EDITOR='/usr/bin/vim'
export PATH=$PATH:/usr/local/play

HISTFILE=~/.zsh_history
HISTSIZE=999999
SAVEHIST=999999

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
zstyle ':completion:*' matcher-list 'm:{a-z}={A-Z}'
zstyle ':completion:*:default' menu select
zstyle ':completion:*:default' list-colors ${(s.:.)LS_COLORS}

alias grep='grep --color=auto -n'
alias ls='ls --color=auto -lhp'
alias tail='tail -n 100'
alias less='less -CR'
alias vi='vim'

alias -s php='php'
alias -s tar='tar xvf'
alias -s zip='unzip'

# ssh-agent
echo -n "ssh-agent: "
source ~/.ssh-agent-info
ssh-add -l >&/dev/null
if [ $? = 2 ] ; then
  echo -n "ssh-agent: restart...."
  ssh-agent >~/.ssh-agent-info
  source ~/.ssh-agent-info
fi
if ssh-add -l >&/dev/null ; then
  # echo "ssh-agent: Identity is already stored."
else
  ssh-add
fi
