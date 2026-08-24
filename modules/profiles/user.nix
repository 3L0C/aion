{config, ...}: let
  hm = config.flake.modules.homeManager;
in {
  # The system side of the user account.
  flake.modules.nixos.user = {
    config,
    lib,
    pkgs,
    ...
  }: let
    ifTheyExist = groups:
      builtins.filter (group: builtins.hasAttr group config.users.groups) groups;
  in {
    users.groups.user = {};
    users.users.user = {
      packages = [pkgs.home-manager];
      isNormalUser = true;
      shell = pkgs.zsh;
      group = "user";
      uid = 1000;
      hashedPasswordFile = config.sops.secrets."passwords/user".path;
      extraGroups =
        [
          "wheel"
        ]
        ++ ifTheyExist [
          "audio"
          "docker"
          "jellyfin"
          "libvirtd"
          "media"
          "navidrome"
          "network"
          "syncthing"
          "video"
        ];

      # TODO: move authorized keys to secrets
      openssh.authorizedKeys.keys = [
        "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIBM61uXhrZmkI+QGEboOUPnYRb1ZMM85qaYKEGeWRTTZ"
      ];
    };

    programs.zsh.enable = true;
    programs.nh.flake = "${config.users.users.user.home}/aion";

    # PAM services for screen lockers
    security.pam.services = lib.mkIf (config.hostSpec.kind != "headless") {
      swaylock = {};
    };

    home-manager.users.user = {
      imports = [hm.base];
      # Values cross to home-manager here; replaces extraSpecialArgs.
      inherit (config) hostSpec;
    };
  };

  # The home-manager base profile: identity, specs, secrets.
  flake.modules.homeManager.base = {
    config,
    lib,
    pkgs,
    ...
  }: {
    imports = with hm; [
      host-spec
      user-spec
      monitors
      secrets
      git
      git-user
      ssh
      authinfo
      tailscale
      yubikey-touch-detector
    ];

    programs.home-manager.enable = true;

    home = {
      stateVersion = "26.11";
      username = "user";
      homeDirectory = "/home/${config.home.username}";
      sessionPath = ["$HOME/.local/bin"];
    };

    # YubiKey touch notification (old home/user/global/yubikey.nix)
    services.yubikey-touch-detector = lib.mkIf (config.hostSpec.kind != "headless") {
      enable = true;
      extraArgs = ["--libnotify"];
    };

    # User preferences, same on all hosts. Hosts override in their
    # home slice.
    userSpec = {
      kbdOptions = lib.mkDefault "";

      theme = {
        base16Scheme = lib.mkDefault "kanagawa-abyss";
        polarity = lib.mkDefault "dark";
        wallpaper = lib.mkDefault ./wallpapers/Blackdune.jpg;
      };

      cursor = {
        package = lib.mkDefault pkgs.rose-pine-cursor;
        name = lib.mkDefault "BreezeX-RosePineDawn-Linux";
        baseSize = lib.mkDefault 24;
      };

      fonts = {
        emoji = {
          package = lib.mkDefault pkgs.noto-fonts-color-emoji;
          name = lib.mkDefault "Noto Color Emoji";
        };
        monospace = {
          package = lib.mkDefault pkgs.nerd-fonts.jetbrains-mono;
          name = lib.mkDefault "JetBrainsMonoNL Nerd Font";
        };
        sansSerif = {
          package = lib.mkDefault pkgs.inter-nerdfont;
          name = lib.mkDefault "Inter Nerd Font";
        };
        serif = {
          package = lib.mkDefault pkgs.inter-nerdfont;
          name = lib.mkDefault "Inter Nerd Font";
        };
        sizes = {
          applications = lib.mkDefault 14;
          desktop = lib.mkDefault 14;
          popups = lib.mkDefault 14;
          terminal = lib.mkDefault 16;
        };
      };

      icons = {
        package = lib.mkDefault pkgs.papirus-icon-theme;
        dark = lib.mkDefault "Papirus-Dark";
        light = lib.mkDefault "Papirus-Light";
      };

      opacity = {
        applications = lib.mkDefault 1.0;
        desktop = lib.mkDefault 1.0;
        popups = lib.mkDefault 1.0;
        terminal = lib.mkDefault 1.0;
      };
    };
  };
}
