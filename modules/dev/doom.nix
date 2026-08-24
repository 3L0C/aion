{
  flake.modules.homeManager.dev = {
    config,
    pkgs,
    ...
  }: {
    home.sessionPath = [
      "${config.xdg.configHome}/emacs/bin"
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
      vips # Image processing system for large images

      # :checkers (spell +aspell)
      (aspellWithDicts ( # A spell checker designed to eventually replace Ispell
        dicts:
          with dicts; [
            # English dictionary for aspell
            en
            # Aspell dictionary for English Computer Jargon
            en-computers
            # Aspell dictionary for English Scientific Jargon
            en-science
          ]
      ))
      dict # Dictionary client

      # :tools lsp
      nodejs # Event-driven I/O framework for the V8 JavaScript engine
      clang # C language family frontend for LLVM (wrapper script)

      # :tools projectile
      universal-ctags # generates an index (or tag) file of language objects found in source files

      # :lang bash
      bash-language-server # Language server for Bash

      # :lang cc
      clang-tools # Standalone command line tools for C++ development

      # :lang haskell
      haskell-language-server # LSP server for GHC
      haskellPackages.hoogle # Haskell API Search
      cabal-install # The command-line interface for Cabal and Hackage

      # :lang java
      jdk # Open-source Java Development Kit

      # :lang lua
      lua-language-server # Language server that offers Lua language support

      # :lang markdown
      pandoc # Conversion between documentation formats

      # :lang nix
      nil # Yet another language server for Nix
      nixfmt # Official formatter for Nix code

      # :lang ocaml
      dune # Composable build system
      ocaml # OCaml is an industrial-strength programming language supporting functional, imperative and object-oriented styles
      ocamlPackages.merlin # Editor-independent tool to ease the development of programs in OCaml
      ocamlPackages.ocaml-lsp # OCaml Language Server Protocol implementation
      ocamlPackages.ocamlformat # Auto-formatter for OCaml code
      ocamlPackages.ocp-indent # Customizable tool to indent OCaml code
      ocamlPackages.utop # Universal toplevel for OCaml
      opam # Package manager for OCaml
      opam-publish # Tool to ease contributions to opam repositories

      # :lang org
      graphviz # Graph visualization tools

      # :lang python
      python3 # High-level dynamically-typed programming language
      isort # Python utility / library to sort Python imports
      pipenv # Python Development Workflow for Humans
      black # Uncompromising Python code formatter
      python313Packages.pytest # Framework for writing tests
      python313Packages.pyflakes # Simple program which checks Python source files for errors
      python313Packages.nose2 # Test runner for Python

      # :lang rust
      cargo # Downloads your Rust project's dependencies and builds your project
      rustc # Safe, concurrent, practical language (wrapper script)
      rust-analyzer # Language server for the Rust language

      # :lang scheme
      mitscheme # MIT/GNU Scheme, a native code Scheme compiler

      # :lang sh
      shellcheck # Shell script analysis tool
      shfmt # Shell parser and formatter

      # :lang web
      stylelint # Mighty CSS linter that helps you avoid errors and enforce conventions
      html-tidy # A tool to tidy down your HTML code to a clear style

      # :lang zig
      zls # Zig LSP implementation + Zig Language Server
      zig # General-purpose programming language and toolchain for maintaining robust, optimal, and reusable software

      # :module mermaid-mode
      mermaid-cli # Generation of diagrams from text in a similar manner as markdown
    ];
  };
}
