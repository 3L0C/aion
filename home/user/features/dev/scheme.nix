{pkgs, ...}: {
  home.packages = with pkgs; [
    mitscheme # MIT/GNU Scheme
  ];
}
