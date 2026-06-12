{pkgs, ...}: {
  home.packages = [
    (pkgs.awakened-poe-trade.overrideAttrs (old: {
      postFixup =
        (old.postFixup or "")
        + ''
          wrapProgram $out/bin/awakened-poe-trade \
            --set XDG_SESSION_TYPE x11
        '';
    }))
  ];
}
