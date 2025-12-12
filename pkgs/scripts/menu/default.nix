{writeShellScriptBin}: let
  mkScript = name: file: writeShellScriptBin name (builtins.readFile file);
in {
  gitignore = mkScript "dmenugitignore" ./dmenugitignore;
  gitignore-auto = mkScript "dmenugitignore-auto" ./dmenugitignore-auto;
  handler = mkScript "dmenuhandler" ./dmenuhandler;
  mount = mkScript "dmenumount" ./dmenumount;
  mountcifs = mkScript "dmenumountcifs" ./dmenumountcifs;
  umount = mkScript "dmenuumount" ./dmenuumount;
  pass = mkScript "dmenupass" ./dmenupass;

  record = mkScript "dmenurecord" ./dmenurecord;
  unicode = mkScript "dmenuunicode" ./dmenuunicode;
  displayselect = mkScript "displayselect" ./displayselect;
  maimpick = mkScript "maimpick" ./maimpick;
  sysact = mkScript "sysact" ./sysact;
}
