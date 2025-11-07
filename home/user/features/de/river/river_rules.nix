{
  lib,
  pkgs,
  ...
}: let
  riverctl = "${lib.getExe' pkgs.river-classic "riverctl"}";
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
  generateAppIdRules = ids:
    lib.concatMapStringsSep "\n" (id: "${riverctl} rule-add -app-id '${id}' ssd") ids;
  generateTitleRules = titles:
    lib.concatMapStringsSep "\n" (title: "${riverctl} rule-add -title '${title}' ssd") titles;
  rulesScript = pkgs.writeShellScript "river-rules" ''
    ${generateAppIdRules ssdAppIds}
    ${generateTitleRules ssdTitles}
    ${riverctl} rule-add ssd
  '';
in {
  systemd.user.services.river-rules = lib.custom.mkWaylandService "river" {
    Unit = {
      Description = "River compositor window rules";
      Documentation = "man:riverctl(1)";
    };

    Service = {
      Type = "oneshot";
      ExecStart = rulesScript;
      RemainAfterExit = true;
    };
  };
}
