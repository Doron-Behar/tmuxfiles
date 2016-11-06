# {{{ change prefix-key:
set-option -g prefix C-s
unbind-key C-b
bind-key C-s send-prefix
set-option -g mode-keys vi
# }}}

# {{{1 General unbindings
# Show clock (who the hell uses it?)
unbind-key t
# run commands faster
bind-key -n M-r command-prompt
# }}}1

# {{{1 Clients
# {{{2 Navigation
# Switch to the last client (using 'M-[' and 'M-]' for next/previous clients)
unbind-key L
# Switch to the previous client
unbind-key (
bind-key -n M-[ switch-client -p
# Switch to the next client
unbind-key )
bind-key -n M-] switch-client -n
# Choose Session from a tree
unbind-key s
bind-key -n M-s choose-tree
# {{{2 Manipulation
# Choose a client to detach
unbind-key D
# Detach client
unbind-key d
bind-key -n M-d detach-client
# Suspend the client
unbind-key C-z
bind-key -n M-z suspend-client
# make renaming current session easier:
bind-key '$' command-prompt -I "rename-session "
# }}}1

# {{{1 Windows
# {{{2 Navigation
unbind-key p
unbind-key n
bind-key -n C-PageUp previous-window
bind-key -n C-PageDown next-window
bind-key -n M-h previous-window
bind-key -n M-l next-window
# Move to the next/previous window with an activity marker
unbind-key M-p
unbind-key M-n
# Switch to the last window
unbind-key l
# Switch to the windows indexed `0-9`
unbind-key 0
unbind-key 1
unbind-key 2
unbind-key 3
unbind-key 4
unbind-key 5
unbind-key 6
unbind-key 7
unbind-key 8
unbind-key 9
# Prompt to search for text in open windows
unbind-key f
bind-key -n M-f command-prompt -I "find-window "
# Choose window from a list
unbind-key w
bind-key -n M-w choose-window
# {{{2 Manipulation
bind-key -n M-PageUp swap-window -t -1
bind-key -n M-PageDown swap-window -t +1
bind-key -n C-S-PageUp swap-window -t -1
bind-key -n C-S-PageDown swap-window -t +1
# Prompt for an index to move the current window
unbind-key .
# splitting vertically
unbind-key '"'
bind-key v split-window -v -c '#{pane_current_path}'
#bind-key s split-window -v -c '#{pane_current_path}' # (Extremley vim like)
# Splitting horizontally
unbind-key %
bind-key h split-window -h -c '#{pane_current_path}'
# Creating new window
unbind-key c
bind-key -n M-n new-window -c '#{pane_current_path}'
# make renaming windows and session process easier
unbind-key ,
bind-key r command-prompt -I "rename-window "
# Killing a window
unbind-key &
bind-key -n M-q confirm-before -p "kill-window #W? (y/n)" kill-window
# Rotate the panes in the current window forwards
unbind-key C-o
#bind-key r rotate-window -U
# Rotate the panes in the current window backwards
unbind-key M-o
#bind-key R rotate-window -D
# }}}1

# {{{1 Panes
# {{{2 Navigation
# Stolen from: https://github.com/joedicastro/dotfiles/blob/master/tmux/.tmux.conf
unbind-key Up
unbind-key Down
unbind-key Left
unbind-key Right
bind-key -n C-h run "(tmux display-message -p '#{pane_current_command}' | grep -iq vim && tmux send-keys C-h) || tmux select-pane -L"
bind-key -n C-j run "(tmux display-message -p '#{pane_current_command}' | grep -iq vim && tmux send-keys C-j) || tmux select-pane -D"
bind-key -n C-k run "(tmux display-message -p '#{pane_current_command}' | grep -iq vim && tmux send-keys C-k) || tmux select-pane -U"
bind-key -n C-l run "(tmux display-message -p '#{pane_current_command}' | grep -iq vim && tmux send-keys C-l) || tmux select-pane -R"
# Display panes
unbind-key q
# {{{2 Manipulation
# Clear the marked pane
unbind-key M
# select the next pane in the current window
unbind-key o
# Prompt for a window index to select
unbind-key "'"
# switch to the last pane
unbind-key \;
# Resizing the pane in steps of 1 cell
unbind-key C-Up
unbind-key C-Down
unbind-key C-Left
unbind-key C-Right
# Resizing the pane in steps of 5 cell
unbind-key M-Up
unbind-key M-Down
unbind-key M-Left
unbind-key M-Right
# Resizing the panes in steps of 1 cell (without prefix)
bind-key -n M-Right resize-pane -R
bind-key -n M-Left resize-pane -L
bind-key -n M-Down resize-pane -D
bind-key -n M-Up resize-pane -U
# Imitating the vim mappings to resizing panes ('windows' in vim) over others
bind-key | resize-pane -x 200
bind-key _ resize-pane -y 200
# Other manipulation for panes:
# Stolen from: http://superuser.com/questions/266567/tmux-how-can-i-link-a-window-as-split-window
bind-key j command-prompt -p "create pane from:" "join-pane -s ':%%'"
unbind-key !
# Take the current pane and create a new window out of it.
bind-key b break-pane
# Kill the current pane
unbind-key x
bind-key -n M-x confirm-before -p "kill-pane #P? (y/n)" kill-pane
#}}}1

# {{{1 Layouts
# Change panes layout
unbind-key space
bind-key -n M-space next-layout
bind-key -n C-space previous-layout
unbind-key M-1
unbind-key M-2
unbind-key M-3
unbind-key M-4
unbind-key M-5
# }}}1

# {{{1 Copy and Paste:
unbind-key [
unbind-key PageUp
bind-key -n M-c copy-mode
bind-key -t vi-copy y copy-pipe 'xclip -in -selection clipboard'
unbind-key ]
bind-key -n M-p paste-buffer
# make the use of e and w more like in my .vimrc
bind-key -t vi-copy e next-word
bind-key -t vi-copy w previous-word
bind-key -t vi-copy E next-space
bind-key -t vi-copy W previous-space
# Show paste buffers
unbind-key '#'
bind-key @ show-buffer
# Choose which buffer to paste interactivly from (just like in vim)
unbind-key =
bind-key '"' choose-buffer
# }}}1

# {{{1 Macros
# Enable running a command in all panes and windows:
bind-key E command-prompt -p "Command:" \
	"run  \"tmux list-sessions                  -F '##{session_name}'        | xargs -I SESS \
			tmux list-windows  -t SESS          -F 'SESS:##{window_index}'   | xargs -I SESS_WIN \
			tmux list-panes    -t SESS_WIN      -F 'SESS_WIN.##{pane_index}' | xargs -I SESS_WIN_PANE \
			tmux send-keys     -t SESS_WIN_PANE '%1' Enter\""
# reload configuration
bind-key R source-file ~/.tmux.conf \; display '~/.tmux.conf sourced'
# }}}1

# vim:ft=tmux:foldmethod=marker