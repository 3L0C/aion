# Scripts for the lf file manager.
{writeShellScriptBin}: let
  mkScript = name: file: writeShellScriptBin name (builtins.readFile file);
in {
  preview = mkScript "lf-preview-script" ./lf-preview-script;

  select = mkScript "lf-select" ./lf-select;

  ueberzug = mkScript "lf-ueberzug" ./lf-ueberzug;
  ueberzug-cleaner = mkScript "lf-ueberzug-cleaner" ./lf-ueberzug-cleaner;
  ueberzug-previewer = mkScript "lf-ueberzug-previewer" ./lf-ueberzug-previewer;

  ext = mkScript "ext" ./ext;

  opout = mkScript "opout" ./opout;

  rotdir = mkScript "rotdir" ./rotdir;

  samedir = mkScript "samedir" ./samedir;

  lf-opener = mkScript "lf-opener" ./lf-opener;

  vidthumb = mkScript "vidthumb" ./vidthumb;
}
