{pkgs, ...}: {
  programs.lf = {
    enable = true;

    settings = {
      # Display settings
      ratios = [
        1
        2
        3
      ];
      shell = "bash";
      shellopts = "-eu";
      ifs = "\\n";
      filesep = "\\n";
      scrolloff = 10;
      period = 1;
      hiddenfiles = ".*:*.aux:*.log:*.bbl:*.bcf:*.blg:*.run.xml";
      mouse = true;
      cursorpreviewfmt = "\\033[7m";
    };

    # Preview and cleaner scripts
    previewer = {
      source = pkgs.writeShellScript "lf-previewer" ''
        draw() {
          ${pkgs.kitty}/bin/kitten icat --stdin no --transfer-mode memory --place "''${w}x''${h}@''${x}x''${y}" "$1" </dev/null >/dev/tty
          exit 1
        }

        file="$1"
        w="$2"
        h="$3"
        x="$4"
        y="$5"

        case "$(${pkgs.file}/bin/file -Lb --mime-type "$file")" in
          image/*)
            draw "$file"
            ;;
          video/*)
            draw "$(${pkgs.custom.scripts.vidthumb}/bin/vidthumb "$file")"
            ;;
        esac

        ${pkgs.pistol}/bin/pistol "$file"
      '';
    };

    extraConfig = ''
      %[ $LF_LEVEL -eq 1 ] || echo "Warning: You're in a nested lf instance"

      # Set cleaner script
      set cleaner ${pkgs.writeShellScript "lf-cleaner" ''
        exec ${pkgs.kitty}/bin/kitten icat --clear --stdin no --transfer-mode memory </dev/null >/dev/tty
      ''}
      source ~/.config/lf/lfrc-commands
      source ~/.config/lf/lfrc-shortcuts
    '';
  };
  xdg.configFile."lf/lfrc-commands".source = ./lfrc-commands;
  xdg.configFile."lf/lfrc-shortcuts".source = ./shortcuts.lfrc;
}
