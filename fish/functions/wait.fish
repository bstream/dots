function wait -d "Wait for the specified process and report its termination status.
  If N is not given, all currently active child processes are waited for,
  and the return code is zero.  N may be a process ID or a job
  specification; if a job spec is given, all processes in the job's
  pipeline are waited for."

  if test -n "$argv"
    fg $argv
    return $status
  end
  for pid in (jobs -p | tail +1)
    if kill -0 $pid 2>/dev/null
      fg $pid
    end
  end
  return $status
end
