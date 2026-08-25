{
  flake.modules.homeManager.fzf =
    {
      config,
      lib,
      pkgs,
      ...
    }:
    {
      programs.fzf = {
        enable = true;

        defaultOptions = [
          "--color 16"
          "--border"
          "--layout=reverse"
          "--height=40%"
        ];
      };

      programs.zsh.plugins = lib.mkIf config.programs.zsh.enable [
        {
          name = "zsh-fzf-tab";
          src = pkgs.zsh-fzf-tab;
          file = "share/fzf-tab/fzf-tab.plugin.zsh";
        }
      ];
    };
}
