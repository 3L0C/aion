{pkgs, ...}: {
  home.packages = with pkgs; [
    aspell # A spell checker designed to eventually replace Ispell
    aspellDicts.en # English dictionary for aspell
    aspellDicts.en-computers # Aspell dictionary for English Computer Jargon
    dict # Dictionary client
  ];
}
