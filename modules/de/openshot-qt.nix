{
  flake.modules.homeManager.openshot-qt = { pkgs, ... }: {
    home.packages = with pkgs; [
      custom.openshot-qt # Free, open-source video editor
    ];
  };
}
