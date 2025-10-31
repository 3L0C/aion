{
  programs.git = {
    enable = true;

    aliases = {
      st = "status";
      co = "checkout";
      br = "branch";
      ci = "commit";
      unstage = "reset HEAD --";
      last = "log -1 HEAD";
    };
    extraConfig = {
      init.defaultBranch = "main";
      pull.rebase = false;
    };
  };
}
