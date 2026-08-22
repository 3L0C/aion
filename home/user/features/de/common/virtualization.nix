{pkgs, ...}: {
  home.packages = with pkgs; [
    libguestfs # Access and modify virtual machine disk images
    qemu # Generic and open source machine emulator and virtualizer
    vde2 # Virtual Distributed Ethernet for emulators like qemu
  ];
}
