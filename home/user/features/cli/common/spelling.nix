{pkgs, ...}: {
  home.packages = with pkgs; [
    # A spell checker designed to eventually replace Ispell
    (aspellWithDicts (
      dicts:
        with dicts; [
          # English dictionary for aspell
          en
          # Aspell dictionary for English Computer Jargon
          en-computers
          # Aspell dictionary for English Scientific Jargon
          en-science
        ]
    ))
    dict # Dictionary client
  ];
}
