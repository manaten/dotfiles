dotfiles
===

# Install

```sh
./init.sh
```

# Recommended tools
- [junegunn/fzf](https://github.com/junegunn/fzf)
- [motemen/ghq](https://github.com/motemen/ghq)
- [direnv/direnv](https://github.com/direnv/direnv)
- [ggreer/the_silver_searcher](https://github.com/ggreer/the_silver_searcher)
- [stedolan/jq](https://github.com/stedolan/jq)
- [tmux/tmux](https://github.com/tmux/tmux)

# mintty settings(with WSL)

```
"%LOCALAPPDATA%\wsltty\bin\mintty.exe " --WSL="Ubuntu" --configdir="%APPDATA%\wsltty" --config="%USERPROFILE%\work\github.com\manaten\dotfiles\minttyrc" -~ /usr/bin/zsh -l
```
