{pkgs, ...}: {
  users.users.user = {
    isNormalUser = true;
    extraGroups = [
      "wheel"
      "networkmanager"
    ];
  };

  # Enable sudo
  security.sudo = {
    enable = true;
    extraRules = [
      {
        commands = [
          {
            command = "${pkgs.systemd}/bin/systemctl suspend";
            options = ["NOPASSWD"];
          }
          {
            command = "${pkgs.systemd}/bin/reboot";
            options = ["NOPASSWD"];
          }
          {
            command = "${pkgs.systemd}/bin/poweroff";
            options = ["NOPASSWD"];
          }
        ];
        groups = ["wheel"];
      }
    ];
    extraConfig = with pkgs; ''
      Defaults:picloud secure_path="${
        lib.makeBinPath [
          systemd
        ]
      }:/nix/var/nix/profiles/default/bin:/run/current-system/sw/bin"
    '';
  };
  programs.zsh.enable = true;
  users.defaultUserShell = pkgs.zsh;
  nixpkgs.config.allowUnfree = true;

  hardware.graphics.enable32Bit = true; # For 32 bit applications
}
