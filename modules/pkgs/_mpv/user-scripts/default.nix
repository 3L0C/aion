# MPV IPC-socket controllers and media handlers, distinct from the Lua
# plugin scripts in mpv-scripts/.
{ writeShellScriptBin }:
let
  mkScript = name: file: writeShellScriptBin name (builtins.readFile file);
in
{
  # Requires the homehub lua script
  hmpv = mkScript "hmpv" ./hmpv;

  # Requires the mpvSockets lua script
  smpv = mkScript "smpv" ./smpv;

  pauseallmpv = mkScript "pauseallmpv" ./pauseallmpv;

  linkhandler = mkScript "linkhandler" ./linkhandler;

  tutorialvids = mkScript "tutorialvids" ./tutorialvids;

  noisereduce = mkScript "noisereduce" ./noisereduce;

  mpv-save = mkScript "mpv-save" ./mpv-save;
}
