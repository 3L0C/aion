{pkgs, ...}: {
  home.packages = with pkgs.custom.scripts; [
    nb
    bs
    vidthumb
    doomemacs
    hmpv
    wip-test
  ];
}
