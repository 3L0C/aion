{lib, ...}: let
  oxbowDevInstall = "/home/user/Projects/oxbow-dev/_build/install/default";
  oxbowDevBin = "${oxbowDevInstall}/bin";

  mkOxbowService = {
    logLevel,
    conflicts,
  }:
    lib.custom.mkWaylandService {
      river = {
        Unit = {
          Description = "oxbow window manager for River 0.4.x (${logLevel} log level)";
          Conflicts = [conflicts];
        };

        Service = {
          Type = "simple";
          ExecStart = "${oxbowDevBin}/oxbow --log-level ${logLevel}";
          Restart = "on-failure";
          RestartSec = "3s";
        };
      };
    };
in {
  home.sessionPath = [oxbowDevBin];
  programs.zsh.initContent = ''
    if [[ -d ${oxbowDevInstall}/share/zsh/site-functions ]]; then
      fpath+=(${oxbowDevInstall}/share/zsh/site-functions)
      autoload -Uz _oxbow _oxctl
      compdef _oxbow oxbow
      compdef _oxctl oxctl
    fi
  '';

  systemd.user.services = {
    oxbow = mkOxbowService {
      logLevel = "info";
      conflicts = "oxbow-debug.service";
    };
    oxbow-debug = removeAttrs (mkOxbowService {
      logLevel = "debug";
      conflicts = "oxbow.service";
    }) ["Install"];
  };
}
