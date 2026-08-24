{
  flake.modules.homeManager.zsh = {
    programs.zsh.shellAliases = {
      # Editor aliases
      vim = "nvim";
      vimdiff = "nvim -d";
      e = "$EDITOR";
      v = "$EDITOR";
      se = "sudoedit";

      # File operations
      cp = "cp -iv";
      mv = "mv -iv";
      rm = "rm -vI";
      mkd = "mkdir -pv";

      # Colorized commands
      grep = "grep --color=auto";
      diff = "diff --color=auto";
      ip = "ip -c";
      ccat = "highlight --out-format=ansi";

      # Common abbreviations
      ka = "killall";
      g = "git";
      p = "python3";
      z = "zathura";
      bc = "bc -ql";

      # Media tools
      yt = "yt-dlp --add-metadata -i";
      yta = "yt -x -f bestaudio/best";
      ffmpeg = "ffmpeg -hide_banner";
      fmpv = "mpv --x11-name=fmpv";

      # Systemctl wrappers
      sctl = "systemctl";
      sys = "systemctl";

      # Tmux shortcuts
      tks = "tmux kill-session";
      tls = "tmux ls";

      # Utility commands
      rsync2 = "rsync --info=progress2 --partial -auvzs";
      debsync = "rsync -avP";
      sf = "grep -R -i --exclude='*.log' --exclude='*.supp'";
      pf = "printf '%s\\n'";

      # Development
      cht = "cht.sh";
      pypi-up = "p -m build && twine upload dist/*";
    };
  };
}
