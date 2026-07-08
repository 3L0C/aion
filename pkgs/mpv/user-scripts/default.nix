{writeShellScriptBin}: let
  mkScript = name: file: writeShellScriptBin name (builtins.readFile file);
in {
  hmpv = mkScript "hmpv" ./hmpv;
  smpv = mkScript "smpv" ./smpv;
  pauseallmpv = mkScript "pauseallmpv" ./pauseallmpv;
  linkhandler = mkScript "linkhandler" ./linkhandler;
  tutorialvids = mkScript "tutorialvids" ./tutorialvids;
  noisereduce = mkScript "noisereduce" ./noisereduce;
  mpv-save = mkScript "mpv-save" ./mpv-save;
}
