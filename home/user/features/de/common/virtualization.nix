{pkgs, ...}: {
  home.packages = with pkgs; [
    libguestfs # Access and modify virtual machine disk images
    qemu # Generic and open source machine emulator and virtualizer
    vde2 # Virtual Distributed Ethernet for emulators like qemu
    virt-manager # Desktop user interface for managing virtual machines
    virt-viewer # A lightweight interface for interacting with the graphical display of virtualized guest OS
  ];
}
