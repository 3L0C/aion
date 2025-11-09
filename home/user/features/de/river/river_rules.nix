{
  lib,
  pkgs,
  config,
  ...
}: let
  riverctl = "${lib.getExe' pkgs.river-classic "riverctl"}";
  floatWidth = config.primaryMonitor.width / 2;
  floatHeight = config.primaryMonitor.height / 2;
  floatRules = [
    {title = "Picture-in-Picture";}
    {title = "*dialog*";}
    {title = "*Dialog*";}
    {title = "*Open File*";}
    {title = "*Save As*";}
    {title = "*Choose File*";}
    {title = "*Select File*";}
    {title = "*Confirm*";}
    {title = "*confirm*";}
    {app-id = "pavucontrol";}
    {app-id = "blueman-manager";}
    {app-id = "lxappearance";}
    {app-id = "qt5ct";}
    {app-id = "qt6ct";}
    {app-id = "nwg-look";}
    {app-id = "font-manager";}
  ];
  ssdRules = [
    {app-id = "org.gnome.*";}
    {app-id = "thunar";}
    {app-id = "pcmanfm";}
    {app-id = "pcmanfm-qt";}
    {app-id = "gimp*";}
    {app-id = "inkscape";}
    {app-id = "krita";}
    {app-id = "firefox";}
    {app-id = "chromium*";}
    {app-id = "librewolf";}
    {app-id = "thunderbird";}
    {app-id = "discord";}
    {app-id = "vesktop";}
    {app-id = "mpv";}
    {app-id = "code*";}
    {app-id = "emacs";}
    {app-id = "libreoffice*";}
    {app-id = "qbittorrent";}
    {app-id = "transmission*";}
    {app-id = "virt-manager";}
    {app-id = "virt-viewer";}
    {app-id = "evince";}
    {app-id = "okular";}
    {app-id = "file-roller";}
    {title = "Picture-in-Picture";}
    {title = "*LibreWolf";}
  ];
  dimensionsRules = [
    {} # Apply 50% x 50% dimensions to all floating windows
  ];
  generateRules = rules: action:
    lib.concatMapStringsSep "\n" (rule: let
      appIdPart = lib.optionalString (rule ? app-id) "-app-id '${rule.app-id}'";
      titlePart = lib.optionalString (rule ? title) "-title '${rule.title}'";
      parts = lib.filter (x: x != "") [appIdPart titlePart];
    in "${riverctl} rule-add ${lib.concatStringsSep " " parts} ${action}")
    rules;
  rulesScript = pkgs.writeShellScript "river-rules" ''
    ${generateRules floatRules "float"}
    ${generateRules dimensionsRules "dimensions ${toString floatWidth} ${toString floatHeight}"}
    ${generateRules ssdRules "ssd"}
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
