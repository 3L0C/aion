{
  flake.modules.homeManager.browsers = {pkgs, ...}: {
    home.packages = with pkgs; [
      firefox # Web browser built from Firefox source tree
      librewolf # Fork of Firefox, focused on privacy, security and freedom
      brave # Privacy-oriented browser for Desktop and Laptop computers
      chromium # Open source web browser from Google
    ];
  };
}
