function update --description 'Runs the varius upgrade commands'
  set -l brew true
  set -l softwareupdate
  set -l installShNotRun # Do not edit this line
  set -l installShNotRun true # Do not edit this line
  set -l useLatestLTSNode # Set this to true if you want the latest LTS of node

  if test -n "$installShNotRun"
    log --error "You must run install.sh in the dots directory before you can run update"
    return 1
  else
    log "Updating dots"
    pushd $dotsDir
    git stash 1>/dev/null # stash any local changes to dots repo
    git pull # pull in updates to dots repo
    git stash pop 1>/dev/null # Re-apply local changes
    popd;
  end

  for arg in $argv
    switch $arg
      case '--no-brew'
        set brew
      case '--softwareupdate'
        set softwareupdate true
      case '--node-lts'
        set useLatestLTSNode true
    end
  end

  if test -n "$softwareupdate"
    log "Updating software"
    softwareupdate -i -a &
  end

  if test -n "$brew"
    log "Updating brew"
    brew update
  end
  wait

  set -l OUTDATED (brew outdated)

  if command -v apm >/dev/null
    log "Upgrading atom"
    apm upgrade --no-confirm
  end

  if test -n "$OUTDATED"
    log "Upgrading brew"
    brew upgrade
    fish -c "fish_update_completions" &
  end

  log "Updating casks"
  # Workaround to update casks
  # Silenced error messages when brew cask installing
  set -l CASKLIST (brew cask list 2>/dev/null)
  for cask in $CASKLIST
    brew cask install $cask 2>/dev/null
  end
  wait

  log "Cleaning up"
  if test -n "$OUTDATED"
    brew cleanup -s --prune-prefix
  end

  switch "$OUTDATED"
    case "*python3*"
      pip3 install --upgrade pip &
    case "*python*"
      pip install --upgrade setuptools
      and pip install --upgrade pip
  end
  wait

  # If 'n' is installed and if the installed version of node is not the latest lts
  if test -n "$useLatestLTSNode"; and hash n > /dev/null 2>&1
    if node -v | grep (n --lts) > /dev/null 2>&1
      log "You already have the latest LTS version of node"
    else
      n lts
    end
  end

  pushd ~/.tacklebox; git pull
  cd ~/.tackle; git pull
  cd ~/.fishmarks; git fetch --all; git reset --hard origin/master;
  popd;

  seq -f "-" -s "" $COLUMNS
  echo
  if test -n "$OUTDATED"
    for pkg in $OUTDATED
      set -l plist (brew info $pkg | sed -n "s| *launchctl unload ~|$HOME|p")
      if test -n "$plist" -a -f "$plist"
        launchctl unload $plist
        launchctl load $plist
        echo Restarted $pkg
      end
    end
    log "Upgraded formulae"
    log --info $OUTDATED
  else
    log "No formulae to upgrade"
  end

  return 0
end
