{
  programs.zsh = {
    enable = true;
    enableCompletion = true;
    autosuggestion.enable = true;
    syntaxHighlighting.enable = true;

    shellAliases = {
      ll = "ls -lA";
      edit = "sudo -e";
      update = "sudo nixos-rebuild switch";
    };

    history = {
      size = 10000;
    };

    setOptions = [
      "HIST_IGNORE_ALL_DUPS"
    ];

    profileExtra = ''
      if [ "$(tty)" = "/dev/tty1" ]; then
        if uwsm check may-start; then
          exec uwsm start -- /run/current-system/sw/bin/Hyprland
        fi
      fi
    '';
  };
}
