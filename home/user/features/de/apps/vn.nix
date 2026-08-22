# Wine visual novel prefix scripts.
{pkgs, ...}: {
  home.packages = with pkgs; [
    custom.scripts.vn.vn-init
    custom.scripts.vn.vn-run
    custom.scripts.vn.vn-shell
    custom.scripts.vn.vn-migrate
  ];
}
