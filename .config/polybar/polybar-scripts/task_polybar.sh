#!/bin/bash

most_urgent_desc=`task rc.verbose: rc.report.next.columns:description rc.report.next.labels:1 limit:1 next`
most_urgent_id=`task rc.verbose: rc.report.next.columns:id rc.report.next.labels:1 limit:1 next`
most_urgent_due=`task rc.verbose: rc.report.next.columns:due.relative rc.report.next.labels:1 limit:1 next`
echo "$most_urgent_id" > /tmp/tw_polybar_id
echo "$most_urgent_desc ·  $most_urgent_due"
