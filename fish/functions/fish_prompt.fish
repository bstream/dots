function fish_prompt --description "Write out the prompt"
  # Must save $status first since it will be overwritten
  set -l _prompt_status $status
  set -l _prompt_job (jobs -p | grep -v Process | wc -l | tr -d " ")
  set -l _prompt_cwd
  set -l _prompt_end

  switch $_prompt_status
    case 0
      set _prompt_status ""(set_color blue)"$_prompt_status"(set_color normal)
    case '*'
      set _prompt_status ""(set_color red)"$_prompt_status"(set_color normal)
  end

  switch $_prompt_job
    case 0
      set _prompt_job ""
    case '*'
      set _prompt_job "|"(set_color --bold blue)"$_prompt_job"(set_color normal)
  end

  switch (pwd)
    case ~
      set _prompt_cwd '~'
    case '*'
      set _prompt_cwd (command basename (pwd))
  end

  switch $USER
    case root toor
      set _prompt_end \#
      set _prompt_cwd ""(set_color $fish_color_cwd_root)"$_prompt_cwd"

    case '*'
      set _prompt_end \$
      set _prompt_cwd ""(set_color $fish_color_cwd)"$_prompt_cwd"
  end
  set _prompt_cwd "$_prompt_cwd"(set_color normal)

  printf '%s[%s%s]%s%s ' $USER $_prompt_status $_prompt_job $_prompt_cwd $_prompt_end
end

