function daily-task -d "run daily task"
  set -l today (date +'%Y/%m/%d')
  set -q DAILY_TASK_DONE_TASK; or set -U DAILY_TASK_DONE_TASK
  if not set -q DAILY_TASK_DAY; or test $DAILY_TASK_DAY!=$today
    set -U DAILY_TASK_DONE_TASK
    set -U DAILY_TASK_DAY $today
  end
  for cmd in $argv
    if not contains "$cmd" $DAILY_TASK_DONE_TASK
      eval "$cmd"; and set -U DAILY_TASK_DONE_TASK $DAILY_TASK_DONE_TASK "$cmd"
    end
  end
end
