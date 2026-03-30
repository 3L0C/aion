{
  description = "A NixOS configuration for every aion";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    nixpkgs-stable.url = "github:nixos/nixpkgs/nixos-25.05";

    nixos-hardware.url = "github:nixos/nixos-hardware";
    lanzaboote = {
      url = "github:nix-community/lanzaboote/v1.0.0";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    disko = {
      url = "github:nix-community/disko";
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
      url = "github:3L0C/wk";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    wk-prompt = {
      url = "github:3L0C/wk-prompt";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    riverdo = {
      url = "github:3L0C/riverdo";
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
    sops-nix = {
      url = "github:Mic92/sops-nix";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    vpn-confinement = {
      url = "github:Maroka-chan/VPN-Confinement";
    };
    secrets = {
      url = "git+ssh://git@github.com-3L0C/3L0C/aion-secrets.git";
      flake = true;
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
    mkNixos = hostname: system: {
      name = hostname;
      value = lib.nixosSystem {
        specialArgs = {
          inherit
            lib
            inputs
            outputs
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
      (mkNixos "yuki" "x86_64-linux")
      (mkNixos "nixos-vm" "x86_64-linux")
      (mkNixos "mikuru" "x86_64-linux")
      (mkNixos "haruhi" "x86_64-linux")
    ];
    homeConfigurations = lib.listToAttrs [
      (mkHome "user" "yuki" "x86_64-linux")
      (mkHome "user" "nixos-vm" "x86_64-linux")
      (mkHome "user" "mikuru" "x86_64-linux")
      (mkHome "user" "haruhi" "x86_64-linux")
    ];
  };
}
