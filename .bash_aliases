## Aliases
alias ls="ls -GFh"
alias ll="ls -la"
alias l.="ls -d .*"
alias f="open -a 'Finder'"
alias s="subl"
alias c="clear"
alias remake="make clean && make"
alias eject_disk1="osascript ~/Documents/eject_disk1.scpt"

# Git aliases
alias g="git"
alias gcm="git commit -m"
alias gst="git status"
alias gco="git checkout"
alias gup="git pull"
alias gad="git add"
alias gph="git push"
alias gcl="git clone"
alias glog="git log --oneline --abbrev-commit --all --graph --decorate --color"

# ???
alias yolo="git pull && git add . && curl -s -X GET http://whatthecommit.com/index.txt | git commit --file - && git push" 

# SSH stuff
alias serverssh="ssh -p 9090 andreas@ports.andreasbrostrom.se"
alias serversshx="ssh -X -p 9090 andreas@ports.andreasbrostrom.se"
alias kthssh="ssh abros@u-shell.csc.kth.se"
alias kthsshx="ssh -X abros@u-shell.csc.kth.se"

# Postgres thingies
alias pg_start='pg_ctl -D /usr/local/var/postgres -l /usr/local/var/postgres/server.log start'
alias pg_stop='pg_ctl -D /usr/local/var/postgres -l /usr/local/var/postgres/server.log stop'