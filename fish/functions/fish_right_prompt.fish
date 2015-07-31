function fish_right_prompt -d "Write out the right prompt"
  set -l _prompt_time (command date -j +%H:%M:%S)
  set _prompt_time ""(set_color --bold "444")"$_prompt_time"(set_color normal)

  printf '%s %s' (__fish_git_prompt) $_prompt_time
end
