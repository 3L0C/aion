{
  flake.modules.homeManager.office = { pkgs, ... }: {
    home.packages = with pkgs; [
      anki # Spaced repetition flashcard program
      gnucash # Personal and small-business financial-accounting application
      # gnumeric # Spreadsheet application for GNOME
    ];
  };
}
