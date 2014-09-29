## Aliases
alias ls="ls -GFh"
alias ll="ls -la"
alias st="open -a 'Sublime Text'"
alias remake="make clean && make"

# Git aliases
alias gcm="git commit -m"
alias gst="git status"
alias gco="git checkout"
alias gup="git pull"
alias gad="git add"

# ???
alias yolo="git pull && git add . && curl -s -X GET http://whatthecommit.com/index.txt | git commit --file - && git push" 

# SSH stuff
SERVERIP="`dig andreasbrostrom.se A | grep andreasbrostrom.se | grep 'A'  | grep -v ';' | awk '{ print $5 }'`"
alias serverssh="ssh -X -p 9090 andreas@${SERVERIP}"
alias kthssh="ssh -X abros@u-shell.csc.kth.se"

# Postgres thingies
alias pg_start='pg_ctl -D /usr/local/var/postgres -l /usr/local/var/postgres/server.log start'
alias pg_stop='pg_ctl -D /usr/local/var/postgres -l /usr/local/var/postgres/server.log stop'