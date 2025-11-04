{pkgs, ...}: {
  home.packages = with pkgs.custom.scripts; [
    nb
    dns-recovery # Emergency DNS recovery for dual-boot time sync issues
  ];
}
