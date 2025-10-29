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

    hyprland.url = "github:hyprwm/Hyprland";

    hypr-contrib = {
      url = "github:hyprwm/contrib";
      inputs.nixpkgs.follows = "hyprland/nixpkgs";
    };

    hyprpicker = {
      url = "github:hyprwm/hyprpicker";
      inputs.nixpkgs.follows = "hyprland/nixpkgs";
    };

    hyprlock = {
      url = "github:hyprwm/hyprlock";
      inputs = {
        hyprgraphics.follows = "hyprland/hyprgraphics";
        hyprlang.follows = "hyprland/hyprlang";
        hyprutils.follows = "hyprland/hyprutils";
        nixpkgs.follows = "hyprland/nixpkgs";
        systems.follows = "hyprland/systems";
      };
    };

    hyprland-plugins = {
      url = "github:hyprwm/hyprland-plugins";
      inputs = {
        hyprland = {
          follows = "hyprland";
        };
      };
    };

    split-monitor-workspaces = {
      url = "github:Duckonaut/split-monitor-workspaces";
      inputs.hyprland.follows = "hyprland";
    };

    waybar.url = "github:Alexays/Waybar";

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
  };

  outputs =
    { nixpkgs, self, ... }@inputs:
    let
      inherit (self) outputs;

      # Basic configuration
      username = "user";
      system = "x86_64-linux";
      lib = nixpkgs.lib;
      localModulesPath = ./modules;
      localSecretsPath = ./secrets;
      localPkgsPath = ./pkgs;
      secrets =
        if builtins.pathExists (localSecretsPath + "/secrets.json")
        then builtins.fromJSON (builtins.readFile (localSecretsPath + "/secrets.json"))
        else {};
      pkgs = import nixpkgs {
        inherit system;
        config.allowUnfree = true;
        overlays = builtins.attrValues (import ./overlays {inherit inputs;});
      };
    in
    {
      nixosConfigurations = {
        snow = nixpkgs.lib.nixosSystem {
          inherit system;
          modules = [
            {nixpkgs.pkgs = pkgs;}

            ./hosts/desktops
            ./hosts/desktops/snow
          ];
          specialArgs = {
            host = "snow";
            inherit self inputs outputs username localModulesPath localSecretsPath localPkgsPath secrets;
          };
        };
      };
    };
}
