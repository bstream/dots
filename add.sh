## declare an array variable
declare -a files=(".bash_aliases" ".bash_profile" ".git-prompt.sh")

## now loop through the above array
for file in "${files[@]}"
do
   cp "$file" "$HOME/$file"
   # or do whatever with individual element of the array
done