# Exports
export PATH=$HOME/.rbenv/bin:/usr/local/bin:/usr/local/sbin:/usr/local/share/npm/bin:/Users/abros/Documents/javacc-6.0/bin:/usr/bin:/bin:/usr/sbin:/sbin:/opt/X11/bin:/usr/local/Cellar/ruby193/1.9.3-p547_1/lib/ruby/gems
export NODE_PATH=/usr/local/lib/node:/usr/local/share/npm/lib/node_modules
export LANG=en_US.UTF-8
export LANGUAGE=en_US.UTF-8
export MSF_DATABASE_CONFIG=/opt/msf/database.yml
export MSF_DATABASE_CONFIG=/usr/local/share/metasploit-framework/config/database.yml

# Ruby magic
if which rbenv > /dev/null; then eval "$(rbenv init -)"; fi

# Aliases
if [ -f ~/.bash_aliases ]; then
		. ~/.bash_aliases
fi

# Git magic
if [ -f ~/.git-prompt.sh ]; then
	source ~/.git-prompt.sh
fi
# Autocomplete for 'g' as well
complete -o default -o nospace -F _git g

# Bash completions
if [ -f $(brew --prefix)/etc/bash_completion ]; then
	. $(brew --prefix)/etc/bash_completion
fi

# Check for upgrades and updates
function upgrade() {
	brew update & 
	sudo softwareupdate -i -a;
	wait
	local OUTDATED=$(brew outdated)
	brew upgrade
	brew cleanup -s
	brew cask cleanup
	brew doctor
	if echo "$OUTDATED" | grep -q "python[^3]"; then
		pip install --upgrade setuptools && pip install --upgrade pip &
	fi
	if echo "$OUTDATED" | grep -q "python3"; then
		pip3 install --upgrade pip &
	fi
	wait
}

function update_serverip() {
	SERVERIP="`dig @candy.ns.cloudflare.com ports.andreasbrostrom.se A | grep ports.andreasbrostrom.se | grep 'A'  | grep -v ';' | awk '{ print $5 }'`"
	unalias serverssh
	alias serverssh="ssh -X -p 9090 andreas@"$SERVERIP
}

function prompt() {
	# Some colors
	# in future use BLACK=$(tput setaf 0) "setaf". Then echo "${BLACK} blabla"
	local YELLOW="\[\e[0;93m\]"
	local GREEN="\[\e[0;92m\]"
	local RED="\[\e[0;91m\]"
	local PLAIN="\[\e[m\]"

	# Build PS1
	local ps1="$PLAIN$YELLOW\u$PLAIN in $YELLOW\W$PLAIN\n\$ "

	git branch &>/dev/null
	if [ $? -eq 0 ]; then
		# In GIT repo
		local GIT_STATUS=$(git status)
		if echo $GIT_STATUS | grep "nothing to commit" > /dev/null 2>&1; then
			# Nothing to commit
			if echo $GIT_STATUS | grep "Your branch is ahead" > /dev/null 2>&1; then
				# Ahead of origin
				GIT_PROMPT="$GREEN$(__git_ps1 "(%s*) ")"
			else
				# On same rev as origin
				GIT_PROMPT="$GREEN$(__git_ps1 "(%s) ")"
			fi
		else
			# Changes to working tree
			if echo $GIT_STATUS | grep "Changes not staged for commit" > /dev/null 2>&1; then
				# Unadded changes
				GIT_PROMPT="$RED$(__git_ps1 "(%s*) ")"
			else
				# Uncommited changes
				GIT_PROMPT="$RED$(__git_ps1 "(%s) ")"
			fi
		fi
	else 
		# Not in GIT repo
		GIT_PROMPT=""
	fi

	export PS1=$(printf "%s%s" "$GIT_PROMPT" "$ps1")
}
# This command gets executed before loading PS1 (and now it sets up PS1 :) )
PROMPT_COMMAND="prompt"

function sync_fork() {
	git fetch upstream
	git checkout master
	git merge upstream/master
}
