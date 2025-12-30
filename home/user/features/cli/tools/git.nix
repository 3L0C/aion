{
  lib,
  config,
  pkgs,
  ...
}: {
  home.packages = with pkgs; [
    git-crypt # Transparent file encryption in git
  ];

  programs.git = {
    enable = true;

    ignores = [
      ".direnv"
      ".env"
      ".envrc"
    ];

    settings = {
      log.date = "iso";

      core.whitespace = "-trailing-space";
      branch.autosetuprebase = "always";
      branch.sort = "committerdate";
      init.defaultBranch = "master";
      merge.conflictStyle = "zdiff3";
      rerere.enabled = true;
      fetch.prune = true;
      pull.ff = "only";
      pull.rebase = true;
      push.autoSetupRemote = true;
    };
  };

  programs.zsh = lib.mkIf config.programs.zsh.enable {
    oh-my-zsh.plugins = ["git"];
  };
}
