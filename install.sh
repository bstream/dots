#!/bin/bash
DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

# Symlink config files in the rc folder, e.g. .gitconfig/.bashrc etc.
cd ~ || exit
for f in $DIR/rc/*; do
  ln -fs "$f" ".$(basename "$f")"
done

# Symlink files in the fish folder
mkdir -p ~/.config/fish
cd ~/.config/fish || exit
for f in $DIR/fish/*; do
  ln -fs "$f"
done

# General good programs to have
tools="git fish wget"
langs="python python3 ruby node"
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
      echo "Enter your password to add fish to '/etc/shells'"
      echo "$fish_location" | sudo tee -a /etc/shells
    fi

    if ! [[ "$SHELL" =~ fish ]]; then
      # Current shell is not fish
      while true; do
        read -r -p "Do you wish to make 'fish' your default shell? (y/n) " answer

        if [[ $answer =~ ^([yY][eE][sS]|[yY])$ ]]; then
          echo "Changing shell to fish!";
          chsh -s "$fish_location";
          break;
        fi

        if [[ $answer =~ ^([nN][oO]|[nO])$ ]]; then
          echo "Will NOT make 'fish' your default shell. This can be changed later by running 'chsh -s $fish_location'";
          break;
        fi
        echo "Please answer y or n.";
      done
    fi
    # Install tacklebox and tackle
    curl -L https://raw.githubusercontent.com/justinmayer/tacklebox/master/tools/install.fish | fish;
    # Install fishmarks
    curl -L https://github.com/techwizrd/fishmarks/raw/master/install.fish | fish
  fi
fi

# Prepare to install secondary packages
cd "$DIR" || exit
mkdir pipCache

# Upgrade package managers
pip install --upgrade pip
npm install --global npm@latest
npm link npm

# Clean up temporary files
rm -rf pipCache node_modules *.gem

echo "Install done. Next steps:"
echo "* Close all active terminal sessions and restart"
echo "* Run 'update' and wait for it to complete. If you run in to any errors try the command again"
echo "* Set up your git config using git config --global user.email 'your.email@domain.com' and git config --global user.name 'Your Name'"
