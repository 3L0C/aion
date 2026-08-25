{
  flake.modules.homeManager.security =
    # Security and Privacy Tools
    { pkgs, ... }: {
      home.packages = with pkgs; [
        seahorse # Application for managing encryption keys and passwords in the GnomeKeyring
        veracrypt # Free Open-Source filesystem on-the-fly encryption
      ];
    };
}
