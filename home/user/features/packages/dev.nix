{ pkgs, ... }:
{
  home.packages = with pkgs; [
    android-studio # The official Android IDE (Stable branch)
    wlroots_0_19 # Modular Wayland compositor library
    wlroots_0_18 # Modular Wayland compositor library
    uwsm # A standalone Wayland session manager
    nixd # nix
    shfmt
    treefmt
    nixfmt-rfc-style
    gcc
    gdb
    gef
    cmake
    gnumake
    valgrind
    llvmPackages_20.clang-tools
    python3
    python312Packages.ipython
    mermaid-cli # Generation of diagrams from text in a similar manner as markdown
  ];
}
