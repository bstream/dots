function update --description 'Runs the varius upgrade commands'
  set -l brew true
  set -l softwareupdate

  for arg in $argv
    switch $arg
      case '--no-brew'
        set brew
      case '--softwareupdate'
        set softwareupdate "true"
    end
  end

  if test -n "$softwareupdate"
    softwareupdate -i -a &
  end

  if test -n "$brew"
    brew update
  end
  wait

  set -l OUTDATED (brew outdated)

  if test -n "$OUTDATED"
    brew upgrade --all
    brew cleanup -s
    fish -c "fish_update_completions" &
  end

  switch "$OUTDATED"
    case "*python3*"
      pip3 install --upgrade pip &
    case "*python*"
      pip install --upgrade setuptools
      and pip install --upgrade pip
  end
  wait

  pushd; 
  cd ~/.tacklebox; git pull
  cd ~/.tackle; git pull; 
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
    echo (set_color --bold yellow)"Upgraded formulae"(set_color normal)
    echo $OUTDATED
  else
    echo (set_color --bold yellow)"No formulae to upgrade"(set_color normal)
  end

  return 0
end
