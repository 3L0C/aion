{pkgs, ...}: {
  home.packages = with pkgs; [
    virt-manager # Desktop user interface for managing virtual machines
    virt-viewer # A lightweight interface for interacting with the graphical display of virtualized guest OS
  ];
}
