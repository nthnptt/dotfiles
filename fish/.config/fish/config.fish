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
