{ localSecretsPath, ... }:
{
  imports = [
    ./bat.nix                         # better cat command
    ./browser.nix                     # firefox based browser
    ./btop.nix                        # resouces monitor 
    ./discord.nix                     # discord
    ./emacs.nix                       # emacs editor
    ./doom.nix                        # An Emacs framework
    ./gtk.nix                         # gtk theme
    ./hyprland                        # window manager
    ./mpv                             # general-purpose media player
    ./nvim                            # neovim editor
    ./packages                        # other packages
    ./scripts                         # personal scripts
    ./waybar                          # status bar
    ./wk                              # Which-Key menu via X11 and Wayland
    ./zsh                             # shell
    (localSecretsPath + "/home")
  ];
}
