{writeShellScriptBin}: let
  mkScript = name: file: writeShellScriptBin name (builtins.readFile file);
in {
  smpv = mkScript "smpv" ./smpv;
  pauseallmpv = mkScript "pauseallmpv" ./pauseallmpv;
  linkhandler = mkScript "linkhandler" ./linkhandler;
  umpv-backup = mkScript "umpv-backup" ./umpv-backup;
  wally = mkScript "wally" ./wally;
  tutorialvids = mkScript "tutorialvids" ./tutorialvids;
  noisereduce = mkScript "noisereduce" ./noisereduce;
  mpv-save = mkScript "mpv-save" ./mpv-save;
}
