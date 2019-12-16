#!/usr/bin/env fish

function load_env
	for f in .env/bin/activate.fish my.fish-env
		if test -f $f
			source $f
		end
	end
end

function cat_menu
	for f in ~/.vim/tmux-menu.txt my.tmux-menu
		if test -f $f
			cat $f
		end
	end
end

function choose_command
	cat_menu | fzf --no-sort --layout=reverse --prompt='Command: '
end

function set_title
	set title (echo $argv[1] | awk 'BEGIN{FS="::"}{print $1}' | sed 's/\s*$//')
	tmux rename-window $title
end

function run_command
	set cmd (echo $argv[1] | awk 'BEGIN{FS=":: "}{print $2}')
	if test -n $cmd
		if test -d $cmd
			fish -C "cd $cmd"
		else
			eval $cmd
		end

		set s $status
		if test $s -ne 0
			echo "==== Command terminated with exit code $s ==="
			read -s -P ""
		end
	end
end

function main
	load_env
	if test "$argv[1]" = "-t"
		tmux rename-window "Run..."
	end

	set cmd (choose_command)

	if test "$argv[1]" = "-t"
		set_title $cmd
	end
	run_command $cmd
end

main $argv[1]

