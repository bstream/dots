function conflicts
	git status --short | grep -E '^UU ' | sed 's/^UU //g' $argv
end
