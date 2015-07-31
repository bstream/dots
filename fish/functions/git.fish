function git --wraps git -d "Fix git requiring bash"
  env SHELL=/bin/bash git $argv
end
