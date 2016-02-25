function log -d "Logs a string to stdout"
  set color cyan
  set message ""

for arg in $argv
  switch $arg
    case '--error'
      set color red
    case '--warning'
      set color yellow
    case '*'
      set message "$message $arg"
  end
end

  if not [ $message ]
    echo ""
  else
    echo (set_color --bold $color)" -- $message"(set_color normal)
  end
end
