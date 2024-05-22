#command improvement
alias ls=exa

# nvim > vim
alias vim=nvim

# tmux
alias tmuxa='tmux a -t $(tmux list-sessions -F "#{session_name}" | fzf)'
. "$HOME/.cargo/env"
