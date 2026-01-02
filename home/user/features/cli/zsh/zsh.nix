{config, ...}: {
  programs.zsh = {
    enable = true;
    enableCompletion = true;
    autosuggestion.enable = true;
    syntaxHighlighting.enable = true;
    defaultKeymap = "viins"; # Start in vi insert mode
    history = {
      size = 10000000;
      save = 10000000;
      path = "${config.xdg.cacheHome}/zsh/history";
      ignoreAllDups = true;
      ignoreDups = true;
      ignoreSpace = true;
      expireDuplicatesFirst = true;
    };
    setOptions = [
      "AUTOCD" # Automatically cd into typed directory
      "INTERACTIVE_COMMENTS" # Allow comments in interactive shell
      "HIST_EXPIRE_DUPS_FIRST"
      "HIST_FIND_NO_DUPS"
      "HIST_IGNORE_ALL_DUPS"
      "HIST_IGNORE_DUPS"
      "HIST_IGNORE_SPACE"
      "HIST_SAVE_NO_DUPS"
    ];

    # Completion styling
    completionInit = ''
      autoload -U compinit
      zstyle ':completion:*' menu select
      zmodload zsh/complist
      compinit
      _comp_options+=(globdots) # Include hidden files
    '';
    initContent = ''
      # Disable ctrl-s to freeze terminal
      stty stop undef
      autoload -U colors && colors
      PS1="%B%{$fg[blue]%}%~%{$reset_color%}
      $%b "

      # Vi mode timeout
      export KEYTIMEOUT=1

      # Vim keys in tab complete menu
      bindkey -M menuselect 'h' vi-backward-char
      bindkey -M menuselect 'k' vi-up-line-or-history
      bindkey -M menuselect 'l' vi-forward-char
      bindkey -M menuselect 'j' vi-down-line-or-history
      bindkey -v '^?' backward-delete-char

      # Change cursor shape for different vi modes
      function zle-keymap-select () {
          case $KEYMAP in
              vicmd) echo -ne '\e[1 q';;      # block cursor in command mode
              viins|main) echo -ne '\e[5 q';; # beam cursor in insert mode
          esac
      }
      zle -N zle-keymap-select

      zle-line-init() {
          zle -K viins # initiate vi insert mode
          echo -ne "\e[5 q" # beam cursor
      }
      zle -N zle-line-init

      echo -ne '\e[5 q' # Use beam shape cursor on startup
      preexec() { echo -ne '\e[5 q' ;} # Use beam shape cursor for each new prompt
      lfcd () {
          tmp="$(mktemp)"
          lf -last-dir-path="$tmp" "$@"
          if [ -f "$tmp" ]; then
              dir="$(cat "$tmp")"
              rm -f "$tmp" >/dev/null
              [ -d "$dir" ] && [ "$dir" != "$(pwd)" ] && cd "$dir"
          fi
      }

      # Custom keybindings
      bindkey -s '^o' 'lfcd\n'               # Ctrl-O: Open lf and cd
      bindkey -s '^a' 'bc -lq\n'             # Ctrl-A: Open calculator
      bindkey -s '^f' 'cd "$(dirname "$(fzf)")"\n' # Ctrl-F: Fuzzy find directory
      bindkey '^[[3~' delete-char            # Delete key

    '';
    profileExtra = "";
    shellAliases = {
    };
  };
}
