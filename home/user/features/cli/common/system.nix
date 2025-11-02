{pkgs, ...}: {
  home.packages = with pkgs; [
    hwdata # Hardware identification data
    lshw # Hardware configuration information tool
  ];
}
