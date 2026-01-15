{
  config,
  inputs,
  pkgs,
  ...
}: {
  imports = [inputs.stylix.nixosModules.stylix];

  stylix = {
    enable = true;
    autoEnable = true;

    base16Scheme = "${pkgs.base16-schemes}/share/themes/kanagawa-abyss.yaml";
    polarity = "dark";
    image = pkgs.fetchurl {
      url = "https://raw.githubusercontent.com/NixOS/nixos-artwork/master/wallpapers/nix-wallpaper-simple-dark-gray.png";
      hash = "sha256-JaLHdBxwrphKVherDVe5fgh+3zqUtpcwuNbjwrBlAok=";
    };
    targets.gtk.enable = config.hostSpec.kind != "headless";
  };
}
