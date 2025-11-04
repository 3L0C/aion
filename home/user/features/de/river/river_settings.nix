{config, ...}: {
  wayland.windowManager.river.settings = {
    default-attach-mode = "top"; # top|bottom|above|below|after <N>

    allow-tearing = "disabled"; # enabled|disabled

    border-width = 4; # pixels
    focus-follows-cursor = "normal"; # disabled|normal|always

    hide-cursor = {
      timeout = 5; # timeout timeout
      when-typing = "enabled"; # when-typing enabled|disabled
    };
    set-cursor-warp = "on-output-change"; # disabled|on-output-change|on-focus-change
    set-repeat = "50 300"; # rate delay
    xcursor-theme = "${config.stylix.cursor.name} ${toString config.stylix.cursor.size}"; # theme_name [size]
  };
}
