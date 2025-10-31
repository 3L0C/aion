{pkgs, ...}: {
  home.packages = with pkgs; [
    thunderbird # Standalone mail and news reader from mozilla.org
  ];
}
