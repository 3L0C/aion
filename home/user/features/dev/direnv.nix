{config, ...}: {
  programs.direnv = {
    enable = true;
    nix-direnv.enable = true;
    enableZshIntegration = config.programs.zsh.enable;
    enableBashIntegration = config.programs.bash.enable;

    config = {
      global = {
        disable_stdin = true;
        strict_env = true;
        warn_timeout = 0;
      };
      whitelist.prefix = [
        "${config.home.homeDirectory}/aion/"
        "${config.home.homeDirectory}/Projects/"
      ];
    };
    silent = true;
  };
}
