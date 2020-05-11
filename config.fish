function cmd_hsplit
	tmux split-pane (commandline)
	commandline -r ''
end

function cmd_vsplit
	tmux split-pane (commandline)
	commandline -r ''
end

bind \es cmd_hsplit
bind \ev cmd_vsplit
