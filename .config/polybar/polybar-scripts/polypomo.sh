#!/usr/bin/env sh

timer_work=1500
timer_break=300
timer_long_break=900

icon_stopped=""
icon_started=""
icon_paused=""
icon_break=""
icon_long_break=""

clr_paused=868d80
clr_work=e68183
clr_break=83b6af
clr_long_break=87c095
clr_stopped=868d80

pipe=/tmp/pomodoro.pipe
mkfifo -m 0600 $pipe
trap "trap - SIGTERM && rm -f $pipe && kill -- -$$" SIGINT SIGTERM EXIT

main() {
  reset
  while true ; do
    sleep 1 &
    wait
    echo ping > $pipe
  done &

  while read pipe ; do
    case "$pipe" in
      ping) [[ $status =~ work|break|long_break ]] && ((paused == 0)) && ((timer--)) ; status ;;
      toggle) toggle ;;
      reset)  reset ;;
      notify) notify status ;;
    esac
  done < $pipe 3> $pipe
}

status() {

  set_timer

  case $status in
    work|break|long_break) 
      if ((paused)) ; then
        foreground=$clr_paused 
        icon=$icon_paused
      else
        case $status in
          work)       
            icon=$icon_started
            foreground=$clr_work
            ;;
          break)      
            icon=$icon_break
            foreground=$clr_break
            ;;
          long_break)
            icon=$icon_long_break
            foreground=$clr_long_break
            ;;
        esac
      fi
      ;;
    stopped) 
      foreground=$clr_stopped
      icon=$icon_stopped
      echo %{F#${foreground}}$icon%{F-} 
      return
      ;;
  esac

  minutes=0$((timer / 60))
  seconds=0$((timer % 60)) 
  remaining=${minutes: -2}:${seconds: -2}

  echo %{F#${foreground}}$icon%{F-}
}

toggle() {
  case $status in
    work|break|long_break) 
      ((paused=(++paused % 2)))
      notify paused
      ;;
    stopped) 
      status=work
      notify started
      ;;
  esac
  status
}

set_timer() {
  if [[ $status != "stopped" ]] ; then
    if ((${timer:=$timer_work} < 0)) ; then
      if (($i % 9 == 0)) ; then
        status=long_break
        timer=$timer_long_break
        notify long-break
        i=1
      elif (($i % 2 == 0)) ; then
        status=work
        timer=$timer_work
        notify started && mpv --no-terminal ~/.peaclock/alert-work.mp3
      else
        status=break
        timer=$timer_break
        notify break
      fi
      ((i++))
    fi
  else
    timer=$timer_work
  fi
}

reset() {
  status=stopped
  paused=0
  i=3
  notify stopped
  set_timer
  status
}

notify() {
  case $1 in
    status) 
      case $status in
        work) notify-send "Pomodoro Timer" "Get to work!\nTime remaining: $remaining" ;;
        break) notify-send "Pomodoro Timer" "Enjoy a short break\nTime remaining: $remaining" ;;
        long-break) notify-send "Pomodoro Timer" "Enjoy a long break\nTime remaining: $remaining" ;;
      esac
      ;;
    stopped) notify-send "Pomodoro Timer" "Timer stopped" ;;
    started) notify-send "Pomodoro Timer" "Timer started" ;;
    paused) notify-send "Pomodoro Timer" "Timer paused" ;;
    break) notify-send "Pomodoro Timer" "Time for a short break" && mpv --no-terminal ~/.peaclock/alert-work.mp3 ;;
    long-break) notify-send "Pomodoro Timer" "Time for a long break" && mpv --no-terminal ~/.peaclock/alert-work.mp3 ;;
  esac
}

main $*
