{
  flake.modules.nixos.virtualization = {pkgs, ...}: {
    users.users.user.extraGroups = ["libvirtd"];

    environment.systemPackages = with pkgs; [
      virt-manager # Desktop user interface for managing virtual machines
      virt-viewer # Viewer for remote virtual machines
      spice # Complete open source solution for interaction with virtualized desktop devices
      spice-gtk # GTK 3 SPICE widget
      spice-protocol # Protocol headers for the SPICE protocol
      virtio-win # Windows VirtIO Drivers
      win-spice # Windows SPICE Drivers
      adwaita-icon-theme
      virtiofsd # vhost-user virtio-fs device backend written in Rust
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

      # "loose" lets packets from libvirt NAT and Tailscale pass the reverse
      # path check.
      checkReversePath = "loose";
    };
  };

  flake.modules.homeManager.virtualization = {pkgs, ...}: {
    home.packages = with pkgs; [
      libguestfs # Access and modify virtual machine disk images
      qemu # Generic and open source machine emulator and virtualizer
      vde2 # Virtual Distributed Ethernet for emulators like qemu
    ];
  };
}
