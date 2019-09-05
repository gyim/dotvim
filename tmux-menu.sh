#!/usr/bin/env fish

if test -f my.fish-env
	source my.fish-env
end

if test -f my.tmux-menu
	set cmd (cat ~/.vim/tmux-menu.txt my.tmux-menu | fzf --no-sort --layout=reverse --prompt="Command: ")
else
	set cmd (cat ~/.vim/tmux-menu.txt | fzf --no-sort --layout=reverse --prompt="Command: ")
end

if test -n $cmd
	set execcmd (echo $cmd | awk 'BEGIN{FS=":: "}{print $2}')
	exec fish -c $execcmd
end
