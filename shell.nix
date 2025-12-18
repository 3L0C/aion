{
  pkgs ? import <nixpkgs> {},
  checks,
  ...
}:
pkgs.mkShell {
  inherit (checks.pre-commit-check) shellHook;
  # bashInteractive first ensures 'bash' command uses full-featured bash
  buildInputs = [pkgs.bashInteractive] ++ checks.pre-commit-check.enabledPackages;

  NIX_CONFIG = "extra-experimental-features = nix-command flakes";
  nativeBuildInputs = builtins.attrValues {
    inherit
      (pkgs)
      nix
      home-manager
      nh
      pre-commit
      deadnix
      statix
      git
      sbctl
      ;
  };
}
