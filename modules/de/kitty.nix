{
  flake.modules.homeManager.kitty =
    { config, ... }:
    let
      colors = config.lib.stylix.colors.withHashtag;
    in
    {
      programs.kitty = {
        enable = true;

        settings = {
          # Font features
          disable_ligatures = "never";

          # Window layout
          remember_window_size = true;
          initial_window_width = 640;
          initial_window_height = 400;

          # Window decorations
          window_border_width = "2pt";
          window_margin_width = 0;
          window_padding_width = 0;

          # Appearance
          # background_opacity = "1.0";
          # dynamic_background_opacity = true;

          # Terminal bell
          enable_audio_bell = false;
          visual_bell_duration = "0.0";
          bell_on_tab = false;

          # Mouse
          copy_on_select = false;
          strip_trailing_spaces = "smart";
          select_by_word_characters = "@-./_~?&=%+#";

          # Performance tuning
          repaint_delay = 2;
          sync_to_monitor = true;

          # Tab behavior
          tab_bar_style = "powerline";
          tab_powerline_style = "slanted";

          # URL handling
          url_color = colors.base0D;
          url_style = "single";
          open_url_with = "default";
          url_prefixes = "http https file ftp gemini irc gopher mailto news git";
          detect_urls = true;

          # Scrollback
          scrollback_lines = 9000;
          scrollback_pager = "less --chop-long-lines --RAW-CONTROL-CHARS +INPUT_LINE_NUMBER";
          scrollback_pager_history_size = 0;
          wheel_scroll_multiplier = "5.0";
          touch_scroll_multiplier = "1.0";

          # Advanced
          allow_remote_control = false;
          clipboard_control = "write-clipboard write-primary";
          term = "xterm-kitty";
        };

        # Keyboard shortcuts (matching st behavior)
        keybindings = {
          # Copy/paste
          "alt+c" = "copy_to_clipboard";
          "alt+v" = "paste_from_clipboard";
          "shift+insert" = "paste_from_clipboard";

          # Scrolling (matching st's alt+k/j and alt+u/d)
          "alt+k" = "scroll_line_up";
          "alt+j" = "scroll_line_down";
          "alt+u" = "scroll_page_up";
          "alt+d" = "scroll_page_down";
          "alt+up" = "scroll_line_up";
          "alt+down" = "scroll_line_down";
          "alt+page_up" = "scroll_page_up";
          "alt+page_down" = "scroll_page_down";

          # Font size (matching st's zoom with shift+alt+up/down)
          "shift+alt+up" = "change_font_size all +2.0";
          "shift+alt+down" = "change_font_size all -2.0";
          "shift+alt+k" = "change_font_size all +2.0";
          "shift+alt+j" = "change_font_size all -2.0";
          "shift+alt+u" = "change_font_size all +4.0";
          "shift+alt+d" = "change_font_size all -4.0";
          "alt+home" = "change_font_size all 0";

          # Background opacity (matching st's alt+s/a transparency)
          "alt+s" = "set_background_opacity -0.05";
          "alt+a" = "set_background_opacity +0.05";

          # Window management
          "alt+enter" = "new_window";
          "alt+w" = "close_window";

          # URL handling (matching st's alt+l and alt+y)
          "alt+l" = "kitten hints --type url --program default";
          "alt+y" = "kitten hints --type url --program @";
        };
      };
    };
}
