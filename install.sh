#!/usr/bin/env bash
DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

# Symlink config files in the rc folder, e.g. .gitconfig/.bashrc etc.
cd ~
for f in $DIR/rc/*; do
  ln -fs "$f" ".$(basename "$f")"
done

# Symlink files in the fish folder
mkdir -p ~/.config/fish
cd ~/.config/fish
for f in $DIR/fish/*; do
  ln -fs "$f"
done

# General good programs to have
tools="git fish wget nmap bash-completion"
langs="python python3 ruby node"
gems="bundler"
# npmPkgs="eslint csslint bower jsdoc"

# Is this running Mac OS X?
if [ "$(uname)" = "Darwin" ]; then
  export PATH="/usr/local/bin:$PATH"

  # Install hombrew if needed
  if ! which -s brew; then
    ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
  fi

  # Prefetch all binaries
  brew fetch --deps $tools $langs &
  wait

  # Install all binaries
  for p in $tools $langs; do
    brew info "$p" | grep -q "Not installed" && brew install "$p"
  done

  # Add global gitignore to config file
  git config --global core.excludesfile ~/.gitignore_global

  if which -s fish; then
    fish_location="$(which fish)"
    
    if ! grep "$fish_location" /etc/shells; then
      echo "Enter your pwassword to add fish to '/etc/shells'"
      echo "$fish_location" | sudo tee -a /etc/shells
    fi

    while true; do 
      read -r -p "Do you wish to make 'fish' your default shell? (y/n) " yn
      case $yn in
        y ) chsh -s "$fish_location"; break;;
        n ) echo "Will NOT make 'fish' your default shell. This can be changed later by running 'chsh -s $fish_location'"; break;;
        * ) echo "Please answer y or n.";;
      esac
    done
  fi
fi

# Prepare to install secondary packages
cd "$DIR"
mkdir pipCache

# Upgrade package managers
pip install --upgrade pip
npm install --global npm@latest
npm link npm

# Install all secondary packages
# npm install --global $npmPkgs
gem install --no-document --local *.gem

# Clean up temporary files
rm -rf pipCache node_modules *.gem

echo "Install done"
