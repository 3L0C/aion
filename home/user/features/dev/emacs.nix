{
  pkgs,
  lib,
  ...
}: {
  stylix.targets.emacs.enable = false;

  programs.emacs = {
    enable = true;
    package = pkgs.emacs-pgtk;
    extraPackages = epkgs: [epkgs.vterm];
  };

  # Emacs daemon service - starts at session startup, doesn't restart on home-manager switch
  systemd.user.services = {
    emacs-efm-server =
      lib.recursiveUpdate
      (lib.custom.mkWaylandService {
        river = {};
      })
      {
        Unit = {
          Description = "Emacs EFM server daemon";
          # Prevent restart when running nh home switch (home-manager sd-switch option)
          X-SwitchMethod = "keep-old";
        };
        Service = {
          Type = "notify";
          ExecStart = "${pkgs.emacs-pgtk}/bin/emacs --fg-daemon=efm";
          ExecStop = "${pkgs.emacs-pgtk}/bin/emacsclient --eval '(kill-emacs)'";
          Restart = "on-failure";
          RestartSec = 3;
        };
      };
    emacs-server =
      lib.recursiveUpdate
      (lib.custom.mkWaylandService {
        river = {};
      })
      {
        Unit = {
          Description = "Emacs server daemon";
          # Prevent restart when running nh home switch (home-manager sd-switch option)
          X-SwitchMethod = "keep-old";
        };
        Service = {
          Type = "notify";
          ExecStart = "${pkgs.emacs-pgtk}/bin/emacs --fg-daemon";
          ExecStop = "${pkgs.emacs-pgtk}/bin/emacsclient --eval '(kill-emacs)'";
          Restart = "on-failure";
          RestartSec = 3;
        };
      };
  };
}
