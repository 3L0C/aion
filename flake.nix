{
  description = "Master nixos configuration";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    nixpkgs-stable.url = "github:nixos/nixpkgs/nixos-25.05";

    lanzaboote = {
      url = "github:nix-community/lanzaboote/v0.4.2";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    nur.url = "github:nix-community/NUR";
    nix-gaming.url = "github:fufexan/nix-gaming";

    nix-flatpak.url = "github:gmodena/nix-flatpak";

    zen-browser.url = "github:0xc000022070/zen-browser-flake";

    ghostty.url = "github:ghostty-org/ghostty";

    wk = {
      url = "git+file:/home/user/programs/Personal/wk-dev?rev=bd1f1ab50f874a6bb0a4350f401778b4f3ec645d";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    mango = {
      url = "github:DreamMaoMao/mango";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    pre-commit-hooks = {
      url = "github:cachix/git-hooks.nix";
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
        checks = self.checks.${pkgs.system};
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
