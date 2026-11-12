set -g fish_greeting
set -gx XDG_CONFIG_HOME $HOME/.config
set -gx EDITOR vim

if test (uname) = Darwin
    source $__fish_config_dir/config-mac.fish
end

fish_add_path --path ~/bin ~/.local/bin

set -g fisher_path ~/.local/share/fisher
set fish_function_path $fish_function_path[1] $fisher_path/functions $fish_function_path[2..]
set fish_complete_path $fish_complete_path[1] $fisher_path/completions $fish_complete_path[2..]
for file in $fisher_path/conf.d/*.fish
    source $file
end

if status is-interactive
    alias ls 'eza --icons=auto --git'
    alias ll 'ls -l'
    alias la 'ls -al'
    alias vim nvim
    alias g git
    alias grep rg
end

set -l local_config $__fish_config_dir/config_local.fish
test -f $local_config; or touch $local_config
source $local_config
