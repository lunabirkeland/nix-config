{
  description = "somewhat modular nixos config";

  nixConfig = {
    extra-substituters = [
      "https://nix-community.cachix.org"
      "https://nvf.cachix.org"
    ];
    extra-trusted-public-keys = [
      "nix-community.cachix.org-1:mB9FSh9qf2dCimDSUo8Zy7bkq5CX+/rkCWyvRCYg3Fs="
      "nvf.cachix.org-1:GMQWiUhZ6ux9D5CvFFMwnc2nFrUHTeGaXRlVBXo+naI="
    ];
  };

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";

    nixpkgs-unstable.url = "github:NixOS/nixpkgs/nixos-unstable";

    nixos-hardware.url = "github:NixOS/nixos-hardware";

    nixpkgs-unfree = {
      url = "github:numtide/nixpkgs-unfree";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    nixpkgs-unstable-unfree = {
      url = "github:numtide/nixpkgs-unfree?ref=nixos-unstable";
      inputs.nixpkgs.follows = "nixpkgs-unstable";
    };

    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    lanzaboote = {
      url = "github:nix-community/lanzaboote";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    stylix = {
      url = "github:nix-community/stylix";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    nixvim-config = {
      url = "github:lunabirkeland/nixvim-config";
      inputs.nixpkgs.follows = "nixpkgs-unstable";
    };

    spicetify-nix = {
      url = "github:Gerg-L/spicetify-nix";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    # probe-rs-rules to set recommended udev rules for probe-rs
    probe-rs-rules.url = "github:jneem/probe-rs-rules";
  };

  outputs = {
    nixpkgs,
    home-manager,
    nixos-hardware,
    lanzaboote,
    stylix,
    ...
  } @ inputs: let
    vars = import ./vars;
    specialArgs = {inherit inputs vars;};
  in {
    nixosConfigurations = {
      caudatus = nixpkgs.lib.nixosSystem {
        inherit specialArgs;
        system = "x86_64-linux";

        modules = [
          {
            nixpkgs.overlays = [
              (_: prev: import ./pkgs prev)
              (final: _: {
                unstable = import inputs.nixpkgs-unstable {
                  inherit (final.stdenv.hostPlatform) system;
                  inherit (final) config;
                };
              })
            ];
          }
          nixos-hardware.nixosModules.lenovo-thinkpad-t14s-amd-gen4
          lanzaboote.nixosModules.lanzaboote
          ./hosts/caudatus

          stylix.nixosModules.stylix
          home-manager.nixosModules.home-manager
        ];
      };
    };
  };
}
