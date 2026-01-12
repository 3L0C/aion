{inputs, ...}: {
  home.file.".authinfo.gpg".source = "${inputs.secrets}/home/user/authinfo.gpg";
}
