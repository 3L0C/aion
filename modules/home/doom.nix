{ pkgs, ... }:
{
  home.sessionPath = [
    "$HOME/.config/emacs/bin"
  ];

  xdg.desktopEntries = {
    doom = {
      name = "Doom Emacs";
      genericName = "Text Editor";
      exec = "doomemacs %F";
      terminal = false;
      categories = [ "Application" "TextEditor" ];
    };

    vdoom = {
      name = "Doom Emacs (Vanilla)";
      genericName = "Text Editor";
      exec = "doomemacs --vanilla %F";
      terminal = false;
      categories = [ "Application" "TextEditor" ];
    };
  };

  home.packages = with pkgs; [
    # :tools lsp
    nodejs

    # :lang haskell
    haskell-language-server
    haskellPackages.hoogle
    cabal-install

    # :lang java
    jdk

    # :lang markdown
    pandoc

    # :lang org
    graphviz

    # :lang python
    isort
    pipenv
    python313Packages.pytest

    # :lang rust
    cargo
    rustc
    rust-analyzer

    # :lang sh
    shellcheck

    # :lang web
    stylelint
    nodePackages.js-beautify
  ];
}
