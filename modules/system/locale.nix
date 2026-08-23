{
  flake.modules.nixos.locale = {
    time.timeZone = "America/Los_Angeles";

    i18n = {
      defaultLocale = "en_US.UTF-8";
      # Keep C.UTF-8 (part of the NixOS default list) so scripts that fall
      # back to LANG=C.UTF-8 do not regress. ja_JP.UTF-8 is for Japanese
      # visual novels under wine (see the vn homeManager aspect).
      supportedLocales = [
        "C.UTF-8/UTF-8"
        "en_US.UTF-8/UTF-8"
        "ja_JP.UTF-8/UTF-8"
      ];
    };
  };
}
