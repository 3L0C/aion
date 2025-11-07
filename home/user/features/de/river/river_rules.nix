{lib, ...}: let
  ssdAppIds = [
    "org.gnome.*"
    "thunar"
    "pcmanfm"
    "pcmanfm-qt"
    "gimp*"
    "inkscape"
    "krita"
    "firefox"
    "chromium*"
    "librewolf"
    "thunderbird"
    "discord"
    "vesktop"
    "mpv"
    "code*"
    "emacs"
    "libreoffice*"
    "qbittorrent"
    "transmission*"
    "virt-manager"
    "virt-viewer"
    "evince"
    "okular"
    "file-roller"
  ];

  ssdTitles = [
    "Picture-in-Picture"
    "*LibreWolf"
  ];
  generateSsdRules = ids:
    lib.listToAttrs (map (id: {
        name = "'${id}'";
        value = "ssd";
      })
      ids);
in {
  wayland.windowManager.river.settings = {
    rule-add = {
      "-app-id" = generateSsdRules ssdAppIds;
      "-title" = generateSsdRules ssdTitles;
      "" = "ssd";
    };
  };
}
