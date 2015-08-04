### REMOVE ANNOYING MESSAGE ###
set fish_greeting ""

### PATH ###
set default_path /usr/bin /usr/sbin /bin /sbin /usr/local/bin ~/bin
set homebrew /usr/local/bin /usr/local/sbin
set -g -x PATH $homebrew $default_path $PATH

### GIT PROMPT ###
set -g __fish_git_prompt_showdirtystate "true"
set -g __fish_git_prompt_showstashstate "true"
set -g __fish_git_prompt_showuntrackedfiles "true"
set -g __fish_git_prompt_showcolorhints "true"
set -g __fish_git_prompt_showupstream "auto"

### ALIASES ###
alias ls="ls -GFh"
alias ll="ls -la"
alias l.="ls -d .*"
alias c="clear"
alias remake="make clean; make"
alias finder="open -a 'Finder'";
alias showFiles='defaults write com.apple.finder AppleShowAllFiles YES; killall Finder /System/Library/CoreServices/Finder.app'
alias hideFiles='defaults write com.apple.finder AppleShowAllFiles NO; killall Finder /System/Library/CoreServices/Finder.app'

# GIT ALIASES
alias g="git"
alias gcm="git commit -m"
alias gst="git status"
alias gco="git checkout"
alias gup="git pull"
alias gph="git push"
alias glog="git log --oneline --abbrev-commit --all --graph --decorate --color"

# ???
alias yolo="git pull; git add --all; curl -s -X GET http://whatthecommit.com/index.txt | git commit --file - ; git push" 

# SSH ALIASES
alias serverssh="ssh -p 9090 andreas@ports.andreasbrostrom.se"
alias serversshx="ssh -X -p 9090 andreas@ports.andreasbrostrom.se"
alias kthssh="ssh abros@u-shell.csc.kth.se"
alias kthsshx="ssh -X abros@u-shell.csc.kth.se"

# EXTRA DISK
alias eject_mbp="echo \"Ejecting extra disk: START\"; osascript -e 'quit app \"Dropbox\"'; diskutil eject disk5; diskutil eject disk4; diskutil eject disk3; diskutil eject disk2; diskutil eject disk1; echo \"Ejecting extra disk: DONE\"";

### CHANGE LS COLORS ###
set -Ux LSCOLORS gxfxbEaEBxxEhEhBaDaCaD

### MAKE SUBLIME ACCESIBLE VIA COMMAND LINE ###
mkdir ~/bin; ln -s "/Applications/Sublime Text.app/Contents/SharedSupport/bin/subl" ~/bin/subl
set -g EDITOR "subl -w"