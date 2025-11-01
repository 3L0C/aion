# Security and Privacy Tools
{pkgs, ...}: {
  home.packages = with pkgs; [
    gnome-keyring # Password and secrets manager
    mullvad-vpn # Mullvad VPN client
    seahorse # GNOME keyring manager GUI
    veracrypt # Disk encryption software
  ];
}
