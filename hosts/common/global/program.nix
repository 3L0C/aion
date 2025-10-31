{pkgs, ...}: {
  programs = {
    dconf.enable = true;
    zsh.enable = true;
    nix-ld = {
      enable = true;
      libraries = with pkgs; [];
    };
  };
}
