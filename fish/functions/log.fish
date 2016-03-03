function log -d "Logs a string to stdout"
  set color $fish_color_comment
  set message ""

for arg in $argv
  switch $arg
    case '--error'
      set color $fish_color_error
    case '--warning'
      set color $fish_color_param
    case '--info'
      set color $fish_color_quote
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
