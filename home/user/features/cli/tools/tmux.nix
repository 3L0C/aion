{
  pkgs,
  config,
  ...
}: let
  # Use stylix colors if available, otherwise use fallback base16 colors
  hasStylex = config.lib ? stylix;
  colors =
    if hasStylex
    then config.lib.stylix.colors.withHashtag
    else {
      # Fallback: Kanagawa-inspired base16 colors
      base00 = "#0d0c0c"; # Background
      base01 = "#12120f";
      base02 = "#1a1a19";
      base03 = "#363646";
      base04 = "#717c7c";
      base05 = "#c5c9c5"; # Foreground
      base06 = "#c8c093";
      base07 = "#e6e3cc";
      base08 = "#e46a78"; # Red
      base09 = "#e48959"; # Orange
      base0A = "#e5c283"; # Yellow
      base0B = "#98bb6c"; # Green
      base0C = "#7eb4c9"; # Cyan
      base0D = "#7fb4ca"; # Blue
      base0E = "#d4879c"; # Magenta
      base0F = "#d4879c";
    };
in {
  programs.tmux = {
    enable = true;
    terminal = "screen-256color";
    historyLimit = 10000;
    baseIndex = 1;
    escapeTime = 0;
    mouse = true;
    keyMode = "vi";

    prefix = "C-b";

    plugins = with pkgs.tmuxPlugins; [
      resurrect
      yank
    ];

    extraConfig = ''
      # Set default shell
      set-option -g default-shell "${pkgs.zsh}/bin/zsh"

      # Override pane-base-index to 0 (default) to match original config
      # The baseIndex module option sets both base-index and pane-base-index to 1,
      # but the TWM configs expect panes to start at 0
      setw -g pane-base-index 0

      # Easy config reload
      bind-key R source-file ~/.config/tmux/tmux.conf \; display-message "tmux.conf reloaded."

      # Helpful info bindings
      bind-key C-h split-window -fbh "man tmux" \; select-layout main-vertical
      bind-key C-l list-keys

      # Setting some misc defaults
      bind-key C-o rotate-window
      bind-key : command-prompt
      bind-key \; command-prompt
      bind-key L clear-history
      bind-key + select-layout main-horizontal
      bind-key = select-layout main-vertical
      bind-key [ copy-mode
      bind-key ] paste-buffer
      bind-key -n C-n copy-mode

      # Setup 'v' to begin selection as in Vim
      bind-key -T copy-mode-vi v send -X begin-selection

      # Update default binding of Enter
      unbind -T copy-mode-vi Enter

      # Status Bar (using stylix base16 colors)
      set-option -g status-interval 1
      set-option -g status-style bg=${colors.base00},fg=${colors.base05}
      set -g status-left '#[fg=${colors.base0D}]#H #[default]'
      set -g status-right '%a %H:%M:%S %p#[default] #[fg=${colors.base0B}]%Y-%m-%d'
      set-option -g pane-active-border-style fg=${colors.base09}
      set-option -g pane-border-style fg=${colors.base0B}
      set-window-option -g other-pane-height 25
      set-window-option -g other-pane-width 80
      set-window-option -g display-panes-time 1500
      set-window-option -g window-status-current-style fg=${colors.base08}
      set-window-option -g window-status-style fg=${colors.base05}
      set-option -g main-pane-height 60%
      set-option -g main-pane-width 60%

      # Set window notifications
      setw -g monitor-activity on
      set -g visual-activity on

      # Allow the arrow key to be used immediately after changing windows
      set-option -g repeat-time 0

      # Kill window
      bind-key Q killw

      # Yank plugin settings
      set -g @yank_action 'copy-pipe'
      set -g @yank_selection 'clipboard'
      set -g @yank_selection_mouse 'clipboard'
      set -g @override_copy_command 'wl-copy'

      # Switch layouts
      bind-key y source-file ~/.config/tmux/twm.conf \; select-layout main-vertical
      bind-key t source-file ~/.config/tmux/twm-horizontal.conf \; select-layout main-horizontal

      # Source horizontal layout at startup (default layout)
      source-file ~/.config/tmux/twm-horizontal.conf
    '';
  };

  xdg.configFile."tmux/twm.conf".text = ''
    # TWM Vertical layout configuration
    # All bindings require prefix key

    # Move focus through pane stack
    bind-key j run "(tmux display-message -p '#{window_zoomed_flag}' | grep -iqE '^1''$' && tmux resize-pane -Z) ; (tmux select-pane -t {next})" \; select-layout main-vertical
    bind-key k run "(tmux display-message -p '#{window_zoomed_flag}' | grep -iqE '^1''$' && tmux resize-pane -Z) ; (tmux select-pane -t {previous})" \; select-layout main-vertical

    # Move pane up or down in stack
    bind-key J run "(tmux display-message -p '#{window_zoomed_flag}' | grep -iqE '^1''$' && tmux resize-pane -Z) ; (tmux display-message -p '#{pane_at_left} #{pane_at_bottom}' | grep -iqE '^0 1''$' && tmux rotate-window -D && tmux select-pane -t0) || (tmux swap-pane -D)" \; select-layout main-vertical
    bind-key K run "(tmux display-message -p '#{window_zoomed_flag}' | grep -iqE '^1''$' && tmux resize-pane -Z) ; (tmux display-message -p '#{pane_at_left} #{pane_at_bottom}' | grep -iqE '^1 1''$' && tmux rotate-window -U && tmux select-pane -t {bottom-right}) || (tmux swap-pane -U)" \; select-layout main-vertical

    # Move to next (+) or prev (-) window
    bind-key l next-window \; select-layout main-vertical
    bind-key h previous-window \; select-layout main-vertical

    # Send current pane to the next (+) or prev (-) window
    bind-key L join-pane -fdbh -t:+ \; select-layout main-vertical
    bind-key H join-pane -fdbh -t:- \; select-layout main-vertical

    # Swap current pane with master pane
    bind-key space run "(tmux display-message -p '#{window_zoomed_flag}' | grep -iqE '^1''$' && tmux resize-pane -Z) ; (tmux display-message -p '#{pane_index}' | grep -iqE '^0''$' && tmux swap-pane -dZ -s1) || (tmux swap-pane -s0)" \; select-layout main-vertical

    # Use <prefix> enter, v, and s to open new panes as master
    bind-key enter run "(tmux display-message -p '#{window_zoomed_flag}' | grep -iqE '^1''$' && tmux resize-pane -Z) ; (tmux split-window -bh -t0)" \; select-layout main-vertical
    bind-key v run "(tmux display-message -p '#{window_zoomed_flag}' | grep -iqE '^1''$' && tmux resize-pane -Z) ; (tmux split-window -bh -t0)" \; select-layout main-vertical
    bind-key s run "(tmux display-message -p '#{window_zoomed_flag}' | grep -iqE '^1''$' && tmux resize-pane -Z) ; (tmux split-window -bh -t0)" \; select-layout main-vertical

    # <prefix> i to zoom the focused pane
    bind-key i resize-pane -Z

    # <prefix> f to focus the master pane
    bind-key f select-pane -t0 \; select-layout main-vertical

    # <prefix> f is rebound above, this is an alternative
    bind-key F command-prompt "find-window -Z -- '%%'"

    # Simple binds for pane/window switching
    bind-key a last-pane \; select-layout main-vertical
    bind-key c new-window \; select-layout main-vertical
    bind-key t next-window \; select-layout main-vertical
    bind-key T previous-window \; select-layout main-vertical

    # Clear screen
    bind-key C-b send-keys 'C-l' \; select-layout main-vertical
    bind-key o send-keys 'C-l' \; select-layout main-vertical
    bind-key C-o select-layout main-vertical

    # Kill pane
    bind-key q killp \; select-pane -t0 \; select-layout main-vertical

    # Bind-key for opening lf
    bind-key r split-window -fb 'lfrun' \; select-layout main-vertical

    # Change layout
    bind-key y source-file ~/.config/tmux/twm.conf \; select-layout main-vertical
    bind-key t source-file ~/.config/tmux/twm-horizontal.conf \; select-layout main-horizontal
  '';

  xdg.configFile."tmux/twm-horizontal.conf".text = ''
    # TWM Horizontal layout configuration (same as default in extraConfig)
    # This file exists for the layout toggle commands

    # Move focus through pane stack
    bind-key j run "(tmux display-message -p '#{window_zoomed_flag}' | grep -iqE '^1''$' && tmux resize-pane -Z) ; (tmux select-pane -t {next})" \; select-layout main-horizontal
    bind-key k run "(tmux display-message -p '#{window_zoomed_flag}' | grep -iqE '^1''$' && tmux resize-pane -Z) ; (tmux select-pane -t {previous})" \; select-layout main-horizontal

    # Move pane up or down in stack
    bind-key J run "(tmux display-message -p '#{window_zoomed_flag}' | grep -iqE '^1''$' && tmux resize-pane -Z) ; (tmux display-message -p '#{pane_at_top} #{pane_at_right}' | grep -iqE '^0 1''$' && tmux rotate-window -D && tmux select-pane -t0) || (tmux swap-pane -D)" \; select-layout main-horizontal
    bind-key K run "(tmux display-message -p '#{window_zoomed_flag}' | grep -iqE '^1''$' && tmux resize-pane -Z) ; (tmux display-message -p '#{pane_at_top} #{pane_at_right}' | grep -iqE '^1 1''$' && tmux rotate-window -U && tmux select-pane -t {bottom-right}) || (tmux swap-pane -U)" \; select-layout main-horizontal

    # Move to next (+) or prev (-) window
    bind-key l next-window \; select-layout main-horizontal
    bind-key h previous-window \; select-layout main-horizontal

    # Send current pane to the next (+) or prev (-) window
    bind-key L join-pane -fdbv -t:+ \; select-layout main-horizontal
    bind-key H join-pane -fdbv -t:- \; select-layout main-horizontal

    # Swap current pane with master pane
    bind-key space run "(tmux display-message -p '#{window_zoomed_flag}' | grep -iqE '^1''$' && tmux resize-pane -Z) ; (tmux display-message -p '#{pane_index}' | grep -iqE '^0''$' && tmux swap-pane -dZ -s1) || (tmux swap-pane -s0)" \; select-layout main-horizontal

    # Use <prefix> enter, v, and s to open new panes as master
    bind-key enter run "(tmux display-message -p '#{window_zoomed_flag}' | grep -iqE '^1''$' && tmux resize-pane -Z) ; (tmux split-window -bh -t0)" \; select-layout main-horizontal
    bind-key v run "(tmux display-message -p '#{window_zoomed_flag}' | grep -iqE '^1''$' && tmux resize-pane -Z) ; (tmux split-window -bh -t0)" \; select-layout main-horizontal
    bind-key s run "(tmux display-message -p '#{window_zoomed_flag}' | grep -iqE '^1''$' && tmux resize-pane -Z) ; (tmux split-window -bh -t0)" \; select-layout main-horizontal

    # <prefix> i to zoom the focused pane
    bind-key i resize-pane -Z

    # <prefix> f to focus the master pane
    bind-key f select-pane -t0 \; select-layout main-horizontal

    # <prefix> f is rebound above
    bind-key F command-prompt "find-window -Z -- '%%'"

    # Simple binds for pane/window switching
    bind-key a last-pane \; select-layout main-horizontal
    bind-key c new-window \; select-layout main-horizontal
    bind-key t next-window \; select-layout main-horizontal
    bind-key T previous-window \; select-layout main-horizontal

    # Clear screen
    bind-key C-b send-keys 'C-l' \; select-layout main-horizontal
    bind-key o send-keys 'C-l' \; select-layout main-horizontal
    bind-key C-o select-layout main-horizontal

    # Kill pane
    bind-key q killp \; select-pane -t0 \; select-layout main-horizontal

    # Bind-key for opening lf
    bind-key r split-window -fb 'lfrun' \; select-layout main-horizontal

    # Change layout
    bind-key y source-file ~/.config/tmux/twm.conf \; select-layout main-vertical
    bind-key t source-file ~/.config/tmux/twm-horizontal.conf \; select-layout main-horizontal
  '';
}
