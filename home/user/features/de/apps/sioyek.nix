{config, ...}: {
  programs.sioyek = {
    enable = true;
    bindings = {
      "screen_down" = "d";
      "screen_up" = "u";
      "zoom_in" = "J";
      "zoom_out" = "K";
      "fit_to_page_width" = "w";
      "fit_to_page_height" = "e";
      "previous_item" = "M";
      "_snp_next" = "N";
      "_snp_prev" = "P";
      "_snp_quit" = "q";
      "_copy_file" = ",yf";
      "_copy_file_page" = ",yp";
      "quit" = "Q";
      "toggle_statusbar" = ",tb";
      "toggle_window_configuration" = ",tp";
      "copy" = "y";
      "goto_mark" = "'";
    };
  };
  xdg.configFile."sioyek/prefs_user.config".text = ''
    font_size ${toString config.userSpec.fonts.sizes.terminal}
    ui_font JetBrainsMonoNL Nerd Font
    background_color 0 0 0
    new_command _snp_next snp -n %{file_path}
    new_command _snp_prev snp -p %{file_path}
    new_command _snp_quit mlm --track %{file_path}
    new_command _copy_file sioyek-copy %{file_path}
    new_command _copy_file_page sioyek-copy %{file_path} %{page_number}
    startup_commands toggle_statusbar
  '';
}
