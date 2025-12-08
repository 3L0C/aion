{pkgs, ...}: {
  home.sessionPath = [
    "$HOME/.config/emacs/bin"
  ];

  xdg.desktopEntries = {
    doom = {
      name = "Doom Emacs";
      genericName = "Text Editor";
      exec = "doomemacs %F";
      terminal = false;
      categories = [
        "Application"
        "TextEditor"
      ];
    };

    vdoom = {
      name = "Doom Emacs (Vanilla)";
      genericName = "Text Editor";
      exec = "doomemacs --vanilla %F";
      terminal = false;
      categories = [
        "Application"
        "TextEditor"
      ];
    };
  };

  home.packages = with pkgs; [
    # Doom Emacs launcher script
    custom.scripts.doomemacs

    # :emacs dired
    vips

    # :tools lsp
    nodejs
    clang

    # :tools projectile
    universal-ctags # generates an index (or tag) file of language objects found in source files

    # :lang cc
    clang-tools

    # :lang haskell
    haskell-language-server
    haskellPackages.hoogle
    cabal-install

    # :lang java
    jdk

    # :lang markdown
    pandoc

    # :lang ocaml
    ocaml
    ocamlPackages.merlin
    ocamlPackages.utop
    ocamlPackages.ocp-indent
    ocamlPackages.dune_3
    ocamlPackages.ocamlformat
    opam

    # :lang org
    graphviz

    # :lang python
    isort
    pipenv
    black
    python313Packages.pytest
    python313Packages.pyflakes
    python313Packages.nose2

    # :lang rust
    cargo
    rustc
    rust-analyzer

    # :lang sh
    shellcheck
    shfmt

    # :lang web
    stylelint
    nodePackages.js-beautify

    # :lang zig
    zls
    zig
    cmake
    gnumake

    # :module mermaid-mode
    mermaid-cli
  ];
}
