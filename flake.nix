{
  inputs = {
    nixpkgs.url = "nixpkgs/nixos-unstable-small";
    nixpkgs-unstable.url = "nixpkgs/nixpkgs-unstable";
    flake-parts.url = "github:hercules-ci/flake-parts";
    nixos-hardware.url = "github:NixOS/nixos-hardware/master";
    colmena = {
      url = "github:zhaofengli/colmena";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    lanzaboote = {
      url = "github:nix-community/lanzaboote/v0.3.0";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    disko = {
      url = "github:nix-community/disko";
      inputs."nixpkgs".follows = "nixpkgs";
    };
    sops-nix = {
      url = "github:Mic92/sops-nix";
      inputs."nixpkgs".follows = "nixpkgs";
    };
    nix-fast-build = {
      url = "github:Mic92/nix-fast-build";
      inputs."nixpkgs".follows = "nixpkgs";
    };
  };
  outputs = inputs: inputs.flake-parts.lib.mkFlake { inherit inputs; } {
    systems = [ "x86_64-linux" "aarch64-linux" ];
    imports = [
      ./hosts
      ./pkgs
    ];
    flake = {
      overlays = {
        colmena = inputs.colmena.overlay;
        iso = final: prev: {
          iso = (inputs.nixpkgs.lib.nixosSystem {
            system = final.stdenv.targetPlatform.system;
            specialArgs = {
              inputs = inputs;
              nixpkgs = inputs.nixpkgs;
            };
            modules = [
              (import ./lib/iso.nix)
            ];
          }).config.system.build.isoImage;
        };
      };

      nixosModules = {
        sops = import ./modules/sops;
        evlli-profile = import ./users/evlli/importable.nix;
      };
    };
    perSystem = { config, pkgs, inputs', self', system, ... }: {
      packages = {
        inherit (inputs'.nix-fast-build.packages) nix-fast-build;
      };
      formatter = pkgs.nixpkgs-fmt;
      devShells.default = pkgs.mkShellNoCC {
        sopsPGPKeyDirs = [
          "${toString ./.}/secrets/keys"
        ];
        sopsCreateGPGHome = "1";
        packages = [
          pkgs.sops
          pkgs.colmena
        #  inputs'.sops-nix.packages.sops-import-keys-hook
        ];
      };
    };
  };
}
