# Amazon Q pre block. Keep at the top of this file.
[[ -f "${HOME}/Library/Application Support/amazon-q/shell/profile.pre.bash" ]] && builtin source "${HOME}/Library/Application Support/amazon-q/shell/profile.pre.bash"
#command improvement
alias ls=eza

# nvim > vim
alias vim=nvim

# tmux
alias tmuxa='tmux a -t $(tmux list-sessions -F "#{session_name}" | fzf)'
#. "$HOME/.cargo/env"

# Amazon Q post block. Keep at the bottom of this file.
[[ -f "${HOME}/Library/Application Support/amazon-q/shell/profile.post.bash" ]] && builtin source "${HOME}/Library/Application Support/amazon-q/shell/profile.post.bash"

export PATH=/Users/yamano/.opencode/bin:$PATH
