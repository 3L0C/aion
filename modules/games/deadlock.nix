{
  flake.modules.nixos.games =
    { pkgs, ... }:
    {
      # hyperline isn't managed by nix because it updates itself.
      programs.nix-ld.libraries = with pkgs; [
        libGL
        libxkbcommon
        vulkan-loader
        wayland
        xorg.libX11
        xorg.libXcursor
        xorg.libXfixes
      ];
    };

  flake.modules.homeManager.games = { pkgs, ... }: {
    home.packages = with pkgs; [
      deadlock-mod-manager
    ];
  };
}
