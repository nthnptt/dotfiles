# Source: https://raw.githubusercontent.com/craftzdog/dotfiles/refs/heads/master/dot_config/fish/functions/cpwd.fish
# Author: Takuya Matsuyama (@craftzdog)
# Adapted: pipes to $COPY_CMD instead of pbcopy

function cpwd --description 'Copy the current directory to the clipboard, with $HOME as ~'
    printf '%s' (string replace -r "^$HOME" '~' -- $PWD) | $COPY_CMD
end
