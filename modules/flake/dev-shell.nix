{
  perSystem =
    {
      config,
      pkgs,
      ...
    }:
    {
      devShells.default = pkgs.mkShell {
        inherit (config.checks.pre-commit-check) shellHook;
        # bashInteractive first ensures 'bash' command uses full-featured bash
        buildInputs = [ pkgs.bashInteractive ] ++ config.checks.pre-commit-check.enabledPackages;

        nativeBuildInputs = builtins.attrValues {
          inherit (pkgs)
            home-manager
            nh
            pre-commit
            deadnix
            statix
            git
            sbctl
            ;
        };
      };
    };
}
