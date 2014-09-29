# Exports
export PATH=$HOME/.rbenv/bin:/usr/local/bin:/usr/local/sbin:/usr/local/share/npm/bin:/Users/abros/Documents/javacc-6.0/bin:/usr/bin:/bin:/usr/sbin:/sbin:/opt/X11/bin:/usr/local/Cellar/ruby193/1.9.3-p547_1/lib/ruby/gems
export NODE_PATH=/usr/local/lib/node:/usr/local/share/npm/lib/node_modules
export LANG=en_US.UTF-8
export LANGUAGE=en_US.UTF-8
export MSF_DATABASE_CONFIG=/opt/msf/database.yml
export MSF_DATABASE_CONFIG=/usr/local/share/metasploit-framework/config/database.yml

# Some colors
RED="\[\e[0;91m\]"
YELLOW="\[\e[0;93m\]"
GREEN="\[\e[0;92m\]"
PURPLE="\[\e[0;34m\]"
CYAN="\[\e[0;36m\]"
GREY="\]\e[0;90m\]"
PLAIN="\[\e[m\]"

# Ruby magic
if which rbenv > /dev/null; then eval "$(rbenv init -)"; fi

# Git magic
if [ -f ~/.git-prompt.sh ]; then
	source ~/.git-prompt.sh
fi

# Aliases
if [ -f ~/.bash_aliases ]; then
    . ~/.bash_aliases
fi

# Bash completions
if [ -f $(brew --prefix)/etc/bash_completion ]; then
	. $(brew --prefix)/etc/bash_completion
fi

# Build PS1
ps1="$PLAIN$YELLOW\u$PLAIN in $YELLOW\W$PLAIN\n\$ "

export PS1='$(git branch &>/dev/null;\
if [ $? -eq 0 ]; then \
  echo "$(echo `git status` | grep "nothing to commit" > /dev/null 2>&1; \
  if [ "$?" -eq "0" ]; then \
    # @4 - Clean repository - nothing to commit
    echo "$(echo `git status` | grep "Your branch is ahead" > /dev/null 2>&1; \
    if [ "$?" -eq "0" ]; then \
    	echo "'$RED'"$(__git_ps1 "(%s) "); \
    else \
    	echo "'$GREEN'"$(__git_ps1 "(%s) "); \
    fi)"; \
  else \
    # @5 - Changes to working tree
    echo "'$CYAN'"$(__git_ps1 "(%s) "); \
  fi) '$ps1'"; \
else \
  # @2 - Prompt when not in GIT repo
  echo "'$ps1'"; \
fi)'


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

