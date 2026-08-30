# Go based command line tool for exercism.io
{
  flake.modules.homeManager.exercism =
    {
      pkgs,
      ...
    }:
    {
      home.packages = [ pkgs.exercism ];
    };
}
