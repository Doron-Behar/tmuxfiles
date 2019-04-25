#!/bin/sh
# Like `tmux select-pane`, but sends a `<C-h/j/k/l>` keystroke if Vim is
# running in the current pane, or only one pane exists.

cmd="$(tmux display -p '#{pane_current_command}')"
cmd="$(basename "$cmd" | tr A-Z a-z)"
pane_count="$(printf %d $(tmux list-panes | wc -l))"

echo "${cmd}" | grep -q 'vi'
if [ $? == 0 ] || [ $pane_count == 1 ]; then
  case "$1" in
    '-L')
      vim_key='C-h'
      ;;
    '-D')
      vim_key='C-j'
      ;;
    '-U')
      vim_key='C-k'
      ;;
    '-R')
      vim_key='C-l'
      ;;
    '-l')
      vim_key='C-\'
      ;;
  esac
  # forward the keystroke to Vim
  tmux send-keys "$vim_key"
else
  tmux select-pane "$@"
fi