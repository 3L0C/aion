{config, ...}: {
  programs.direnv = {
    enable = true;
    nix-direnv.enable = true;
    enableZshIntegration = config.programs.zsh.enable;

    config = {
      global = {
        disable_stdin = true;
        strict_env = true;
        warn_timeout = 0;
      };
      whitelist.prefix = [
        "${config.home.homeDirectory}/nixos-config"
        "${config.home.homeDirectory}/programs/"
        "${config.home.homeDirectory}/repos/"
      ];
    };
    silent = true;
  };
}
