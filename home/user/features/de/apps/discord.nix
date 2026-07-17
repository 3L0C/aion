{pkgs, ...}: {
  home.packages = with pkgs; [
    master.vesktop # Alternate client for Discord with Vencord built-in
  ];
}
