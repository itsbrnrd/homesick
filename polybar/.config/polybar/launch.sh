#!/usr/bin/env sh

pkill polybar

# Wait until the processes have been shut down
while pgrep -a polybar >/dev/null; do sleep 1; done

polybar polypocket &

echo "Bars launched..."