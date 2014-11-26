## declare an array variable
declare -a files=(".bashrc" ".bash_aliases" ".bash_profile" ".git-prompt.sh" ".gitconfig")

## now loop through the above array
for file in "${files[@]}"
do
	if [[ -e "$HOME/$file" ]]
	then
		if [[ -e "$HOME/$file.old" ]]
		then
			echo "$HOME/$file.old already exists, won't replace it"
		else
			mv "$HOME/$file" "$HOME/$file.old"
		fi
	fi
	ln -s "$PWD/$file" "$HOME/$file"
	# or do whatever with individual element of the array
done