{pkgs, ...}: {
  home.packages = with pkgs; [
    pcmanfm # File manager with GTK interface
  ];
}
