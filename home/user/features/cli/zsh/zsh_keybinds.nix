{
  programs.zsh = {
    initContent = ''
      bindkey -e

      WORDCHARS='~!#$%^&*(){}[]<>?.+;-'

      ""{back,for}ward-word() WORDCHARS=$MOTION_WORDCHARS zle .$WIDGET
      zle -N backward-word
      zle -N forward-word
      if [[ -n "''${terminfo[kpp]}" ]]; then
        bindkey -M emacs "''${terminfo[kpp]}" up-line-or-history
        bindkey -M viins "''${terminfo[kpp]}" up-line-or-history
        bindkey -M vicmd "''${terminfo[kpp]}" up-line-or-history
      fi
      if [[ -n "''${terminfo[knp]}" ]]; then
        bindkey -M emacs "''${terminfo[knp]}" down-line-or-history
        bindkey -M viins "''${terminfo[knp]}" down-line-or-history
        bindkey -M vicmd "''${terminfo[knp]}" down-line-or-history
      fi
      autoload -U up-line-or-beginning-search
      zle -N up-line-or-beginning-search

      bindkey -M emacs "^[[A" up-line-or-beginning-search
      bindkey -M viins "^[[A" up-line-or-beginning-search
      bindkey -M vicmd "^[[A" up-line-or-beginning-search
      if [[ -n "''${terminfo[kcuu1]}" ]]; then
        bindkey -M emacs "''${terminfo[kcuu1]}" up-line-or-beginning-search
        bindkey -M viins "''${terminfo[kcuu1]}" up-line-or-beginning-search
        bindkey -M vicmd "''${terminfo[kcuu1]}" up-line-or-beginning-search
      fi
      autoload -U down-line-or-beginning-search
      zle -N down-line-or-beginning-search

      bindkey -M emacs "^[[B" down-line-or-beginning-search
      bindkey -M viins "^[[B" down-line-or-beginning-search
      bindkey -M vicmd "^[[B" down-line-or-beginning-search
      if [[ -n "''${terminfo[kcud1]}" ]]; then
        bindkey -M emacs "''${terminfo[kcud1]}" down-line-or-beginning-search
        bindkey -M viins "''${terminfo[kcud1]}" down-line-or-beginning-search
        bindkey -M vicmd "''${terminfo[kcud1]}" down-line-or-beginning-search
      fi
      bindkey -M emacs '^[[3;5~' kill-word
      bindkey -M viins '^[[3;5~' kill-word
      bindkey -M vicmd '^[[3;5~' kill-word
      bindkey -M emacs '^[[1;5C' forward-word
      bindkey -M viins '^[[1;5C' forward-word
      bindkey -M vicmd '^[[1;5C' forward-word
      bindkey -M emacs '^[[1;5D' backward-word
      bindkey -M viins '^[[1;5D' backward-word
      bindkey -M vicmd '^[[1;5D' backward-word

      bindkey '\ew' kill-region                             # [Esc-w] - Kill from the cursor to the mark
      bindkey -s '\el' 'ls\n'                               # [Esc-l] - run command: ls
      bindkey ' ' magic-space                               # [Space] - don't do history expansion
      autoload -U edit-command-line
      zle -N edit-command-line
      bindkey '\C-x\C-e' edit-command-line
      bindkey "^[m" copy-prev-shell-word
      my-backward-delete-word() {
          local WORDCHARS=$WORDCHARS
          WORDCHARS="''${WORDCHARS//:}"
          WORDCHARS="''${WORDCHARS//\/}"
          WORDCHARS="''${WORDCHARS//.}"
          WORDCHARS="''${WORDCHARS//-}"
          zle backward-delete-word
      }
      zle -N my-backward-delete-word
      bindkey '^W' my-backward-delete-word
    '';
  };
}
