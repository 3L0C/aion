{inputs, ...}: let
  secretsDir = inputs.secrets.outPath;
in {
  home.file.".authinfo.gpg".source = "${secretsDir}/home/user/authinfo.gpg";
}
