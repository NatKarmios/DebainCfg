if [[ "$TERM" != "screen" ]]; then
  tx
  exit
fi

cd ~/.DebianCfg/startup/
py startup.py
cd - > /dev/null
