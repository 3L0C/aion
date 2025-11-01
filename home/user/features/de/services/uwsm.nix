{pkgs, ...}: {
  home.packages = with pkgs; [
    uwsm # Universal Wayland Session Manager
  ];
}
