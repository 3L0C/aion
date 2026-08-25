# Android device integration and development tools
{
  flake.modules.homeManager.android = { pkgs, ... }: {
    home.packages = with pkgs; [
      android-file-transfer # Android MTP client with minimalistic UI
      android-tools # Android SDK platform tools (adb, fastboot, etc.)
      scrcpy # Display and control Android devices from desktop
    ];
  };
}
