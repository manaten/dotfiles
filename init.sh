#!/bin/sh
for i in .yarnrc .bashrc .gitconfig .gitmessage .gitignore.global .gitattributes.global .tmux.conf .vimrc .zshrc .direnvrc .editorconfig
do
  ln -fs `pwd`/$i ~/$i
done

