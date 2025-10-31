{pkgs, ...}: {
  home.packages = with pkgs; [
    gnucash # Personal and small-business financial-accounting application
    gnumeric # Spreadsheet application for GNOME
  ];
}
