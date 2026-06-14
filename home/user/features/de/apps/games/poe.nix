{pkgs, ...}: {
  home.packages = with pkgs; [
    awakened-poe-trade # Path of Exile trading app for price checking
  ];
}
