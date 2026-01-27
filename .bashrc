export LANG=en_US.UTF-8
export LC_ALL=$LANG
export OUTPUT_CHARSET=utf8
export FZF_DEFAULT_OPTS='--color=fg+:255,hl+:255 --exact'

export GOPATH=$HOME/.go
export EDITOR=vim
export GHQ_ROOT=~/work

export PATH=$GOPATH/bin:$PATH

[ -f ~/.fzf.bash ] && source ~/.fzf.bash

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
  echo "ssh-agent: Identity is already stored."
else
  ssh-add
fi

# ctrl-] ?ghq+fzf
bind '"\C-]": " \C-e\C-ucd $GHQ_ROOT/$(ghq list | fzf)\e\C-e\e^\er"'

# Added by LM Studio CLI (lms)
export PATH="$PATH:/Users/manaten/.lmstudio/bin"
# End of LM Studio CLI section


source ~/.safe-chain/scripts/init-posix.sh # Safe-chain bash initialization script
