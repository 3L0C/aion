{
  programs.git = {
    enable = true;

    settings = {
      alias = {
        st = "status";
        co = "checkout";
        br = "branch";
        ci = "commit";
        unstage = "reset HEAD --";
        last = "log -1 HEAD";
      };
      init.defaultBranch = "main";
      pull.rebase = false;
    };
  };
}
