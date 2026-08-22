{
  config,
  pkgs,
  ...
}: {
  programs.mpv = {
    scripts = [pkgs.custom.mpvScripts.homehub];
    scriptOpts = {
      homehub = {
        enable = false;
        module_directory = "~~/script-modules";
        # Default ui mode
        ui_default_mode = "text";
        ui_autostart = false;
        # Keybinds file path
        keybinds_file = "~~/script-opts/homehub-keybinds.json";
        # ASS configuration
        # Font settings
        font_name_body = "mpv-osd-symbols";
        font_color_body = "ffffff";
        font_color_cursor = "00ccff";
        font_color_selected = "00ff00";
        font_color_multiselect = "fcad88";
        font_color_accent = "00ff00";
        font_color_secondary = "aaaaaa";
        font_color_warning = "413eff";
        # Cursor and selection markers
        normal_icon = "○";
        selected_icon = "◉";
        cursor_icon = "▶";
        cursor_selected_icon = "➤";
        # Alignment
        align_x = "left";
        align_y = "top";
        # Layout
        scaling_factor_body = "1";
        screen_margin_ratio = "0.05";
        # Adapter configuration
        adapter_config_file = "~~/script-opts/homehub-adapters.json";
        # Search settings
        search_case_sensitive = false;
        search_show_match_count = true;
        search_fields = "primary_text,secondary_text";
      };
    };
  };

  # Jellyfin password secret for homehub adapter config
  sops.secrets."jellyfin/password" = {};

  # Adapter config with secret injected via sops template
  sops.templates."homehub-adapters.json" = {
    content = ''
      [
          {
              "id": "jellyfin",
              "display_name": "Jellyfin",
              "type": "jellyfin",
              "enabled": true,
              "url": "https://jellyfin.colebruns.com",
              "username": "cole",
              "password": "${config.sops.placeholder."jellyfin/password"}",
              "auto_play_next": true,
              "views": {
                  "libraries": true,
                  "continue_watching": true,
                  "next_up": true,
                  "latest": true
              },
              "update_cache": 300,
              "completion_thresh": 0.95
          }
      ]
    '';
    path = "${config.xdg.configHome}/mpv/script-opts/homehub-adapters.json";
  };

  xdg.configFile."mpv/script-opts/homehub-keybinds.json".text = ''
    {
        "global": {
            "prev": ["CTRL+ENTER"],
            "next": ["ENTER"]
        },
        "text": {
            "up": ["UP"],
            "down": ["DOWN"],
            "back": ["LEFT"],
            "select": ["RIGHT", "ENTER"],
            "multiselect": ["CTRL+ENTER", "SPACE"],
            "page_up": ["PGUP", "CTRL+UP"],
            "page_down": ["PGDWN", "CTRL+DOWN"],
            "search": ["/"],
            "help": ["?"],
            "toggle": ["CTRL+j", "MENU"]
        }
    }
  '';
}
