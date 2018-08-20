#!/bin/sh
for i in .bashrc .gitconfig .gitmessage .gitignore.global .gitattributes.global .tmux.conf .vimrc .zshrc .direnvrc .editorconfig
do
  ln -fs `pwd`/$i ~/$i
done

