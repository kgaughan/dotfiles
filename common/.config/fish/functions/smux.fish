function smux
	ssh -t $argv[1] "tmux has && tmux attach || tmux"
end
