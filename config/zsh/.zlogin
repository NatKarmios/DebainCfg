if [[ "$TERM" != "screen" ]]; then
  tx
  exit
fi

py ~/.config/startup/startup.py
