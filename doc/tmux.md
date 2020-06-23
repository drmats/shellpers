# tmux

## shell

```
tmux list-sessions
tmux attach-session -t [number]
tmux show-buffer
```

* `tmux list-sessions` - `tmux ls`
* `tmux attach-session` - `tmux a`

## keyboard shortcuts

* `^a then c` - create a new window
* `^a then d` - detach session
* `^a then n` - switch to the next window
* `^a then ,` then `[type something]` then `[enter]` - rename the current window
* `^a then %` - split the current window into panes vertically
* `^a then "` - split the current window into panes horizontally
* `^a then ↑` - move to the above pane (works for all four arrows)
* `^a then q` - show pane numbers, then (optionally) the number to switch to that pane
* `^a then [alt]+↑` - resize the current pane up (works for all four arrows)
* `^a then [ctrl]+↑` - resize the current pane up (works for all four arrows)
* `^a then x` - kill the current pane (or window if it only has one pane)
* `^a then [` - enter copy mode, then four arrow keys to move, `[ctrl]+[space]` - enter block mode, `[alt]+w` - copy
* `^a then ]` - paste buffer
* `^a then w` - list windows
* `^a then t` - big clock
* `^a then :` - invoke command line

## commands

* `setw synchronize-panes on` - pass keypresses to all visible panes
* `setw synchronize-panes off` - return to normal
