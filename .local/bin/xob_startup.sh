#!/usr/bin/env bash
set -euo pipefail

alsa-vol-watcher.sh | xob -s volume &
brightness-watcher.py | xob -s backlight &
