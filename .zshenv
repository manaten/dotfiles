# ssh-agent の場所を固定する（どの起動のしかたの zsh でも同じ agent を見るように）
# 既に設定されていれば（ssh の agent forward、macOS の launchd など）それを使う
export SSH_AUTH_SOCK="${SSH_AUTH_SOCK:-$HOME/.ssh/agent.sock}"
