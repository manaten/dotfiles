#!/bin/sh

set -x

PWD="$(pwd)"

for i in .bashrc .gitconfig .gitmessage .gitignore.global .gitattributes.global .tmux.conf .vimrc .zshrc .direnvrc .editorconfig
do
  ln -fs "$PWD/$i" ~/$i
done

ln -fs "$PWD/mise_config.toml" ~/.config/mise/config.toml
