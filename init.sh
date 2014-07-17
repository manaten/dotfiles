#!/bin/sh
for i in .bashrc .gitconfig .gitmessage .globalignore .screenrc .tmux.conf .vimrc .zshrc
do
  ln -fs `pwd`/$i ~/$i
done

