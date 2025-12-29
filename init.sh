#!/bin/sh

PWD="$(pwd)"

for i in .bashrc .gitconfig .gitmessage .gitignore.global .gitattributes.global .tmux.conf .vimrc .zshrc .editorconfig
do
  ln -fsv "$PWD/$i" ~/$i
done

mkdir -pv ~/.config/mise
ln -fsv "$PWD/mise_config.toml" ~/.config/mise/config.toml

mkdir -pv ~/.claude
ln -fsv "$PWD/.claude/settings.json" ~/.claude/settings.json
