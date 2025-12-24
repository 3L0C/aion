{pkgs, ...}: {
  users.users.user.extraGroups = ["libvirtd"];
  environment.systemPackages = with pkgs; [
    virt-manager
    virt-viewer
    spice
    spice-gtk
    spice-protocol
    virtio-win
    win-spice
    adwaita-icon-theme
    virtiofsd
  ];
  virtualisation = {
    libvirtd = {
      enable = true;
      qemu = {
        swtpm.enable = true;
        vhostUserPackages = [pkgs.virtiofsd];
      };
    };
    spiceUSBRedirection.enable = true;
  };
  services.spice-vdagentd.enable = true;
  networking.firewall = {
    trustedInterfaces = ["virbr0"];
    checkReversePath = false;
  };
}
