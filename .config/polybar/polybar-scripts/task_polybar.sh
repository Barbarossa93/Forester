#!/bin/bash

#most_urgent_desc=`task rc.verbose: rc.report.next.columns:description rc.report.next.labels:1 limit:1 next`
most_urgent_urgency=`task rc.verbose: rc.report.next.columns:urgency rc.report.next.labels:1 limit:1 next`
most_urgent_id=`task rc.verbose: rc.report.next.columns:id rc.report.next.labels:1 limit:1 next`
#most_urgent_due=`task rc.verbose: rc.report.next.columns:due.relative rc.report.next.labels:1 limit:1 next`
echo "$most_urgent_id" > /tmp/tw_polybar_id

if (( $(echo "$most_urgent_urgency >= 1" |bc -l) )); then
	echo '%{A1:task "$((`cat /tmp/tw_polybar_id`))" done:}%{F#e39b7b}%{F-}%{A}'
	#if [[ "$most_urgent_due" == "" ]]; then
	#	echo "$most_urgent_desc "
	#else
	#	echo "$most_urgent_desc · %{F#d9bb80}%{F-} $most_urgent_due "
	#fi
else
	echo "%{F#868d80}%{F-}"
fi
