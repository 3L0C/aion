{
  description = "Master nixos configuration";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    nixpkgs-stable.url = "github:nixos/nixpkgs/nixos-25.05";

    nixos-hardware.url = "github:nixos/nixos-hardware";
    lanzaboote = {
      url = "github:nix-community/lanzaboote/v0.4.3";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    nur.url = "github:nix-community/NUR";
    nix-gaming.url = "github:fufexan/nix-gaming";

    nix-flatpak.url = "github:gmodena/nix-flatpak";

    nix-index-database = {
      url = "github:nix-community/nix-index-database";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    zen-browser.url = "github:0xc000022070/zen-browser-flake";

    ghostty.url = "github:ghostty-org/ghostty";

    wk = {
      url = "git+file:/home/user/programs/Personal/wk-dev?rev=645cb1ee2f55081f2299d8c73f46fe2049227cbd";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    river-swap = {
      url = "git+file:/home/user/programs/Personal/river-swap-dev?rev=5e155918cdd5bd2b539a081cb341124494f9567f";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    pre-commit-hooks = {
      url = "github:cachix/git-hooks.nix";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    stylix = {
      url = "github:danth/stylix";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = {
    self,
    nixpkgs,
    home-manager,
    ...
  } @ inputs: let
    inherit (self) outputs;
    lib = nixpkgs.lib.extend (_: _: (import ./lib {inherit (nixpkgs) lib;}) // home-manager.lib);
    supportedSystems = [
      "x86_64-linux"
    ];
    pkgsFor = lib.genAttrs supportedSystems (
      system:
        import nixpkgs {
          inherit system;
          config.allowUnfree = true;
          overlays = builtins.attrValues (import ./overlays {inherit inputs;});
        }
    );
    forEachSystem = f: lib.genAttrs supportedSystems (sys: f pkgsFor.${sys});
    secrets = let
      secretsPath = ./secrets + "/secrets.json";
      secretsExist = builtins.pathExists secretsPath;
      tryReadSecrets = builtins.tryEval (builtins.fromJSON (builtins.readFile secretsPath));
    in
      if !secretsExist
      then {}
      else if tryReadSecrets.success
      then tryReadSecrets.value
      else {};
    mkNixos = hostname: system: {
      name = hostname;
      value = lib.nixosSystem {
        specialArgs = {
          inherit
            lib
            inputs
            outputs
            secrets
            ;
          aionRev = self.shortRev or self.dirtyShortRev or "dirty";
        };
        modules = [
          {nixpkgs.pkgs = pkgsFor.${system};}

          ./hosts/${hostname}/spec.nix
          ./hosts/${hostname}
        ];
      };
    };
    mkHome = username: hostname: system: {
      name = "${username}@${hostname}";
      value = lib.homeManagerConfiguration {
        extraSpecialArgs = {
          inherit
            lib
            inputs
            outputs
            secrets
            ;
          inherit (import ./hosts/${hostname}/spec.nix) hostSpec;
        };
        pkgs = pkgsFor.${system};
        modules = [./home/${username}/${hostname}.nix];
      };
    };
  in {
    legacyPackages = forEachSystem (pkgs: pkgs.custom);
    formatter = forEachSystem (pkgs: pkgs.alejandra);
    checks = forEachSystem (pkgs: import ./checks.nix {inherit inputs pkgs;});
    devShells = forEachSystem (pkgs: {
      default = import ./shell.nix {
        inherit pkgs;
        checks = self.checks.${pkgs.stdenv.hostPlatform.system};
      };
    });
    nixosConfigurations = lib.listToAttrs [
      (mkNixos "snow" "x86_64-linux")
    ];
    homeConfigurations = lib.listToAttrs [
      (mkHome "user" "snow" "x86_64-linux")
    ];
  };
}
