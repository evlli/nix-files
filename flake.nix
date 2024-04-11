{
  inputs = {
    nixpkgs.url = "nixpkgs/nixos-unstable";
    nixpkgs-unstable.url = "nixpkgs/nixpkgs-unstable";

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
  };

  outputs = inputs @ { self, nixpkgs, nixpkgs-unstable, home-manager, colmena, lanzaboote, ... }:
    let
      inherit (self) outputs;
      systems = [ "aarch64-linux" "i686-linux" "x86_64-linux" "aarch64-darwin" "x86_64-darwin" ];
      forAllSystems = lib.genAttrs systems;
      lib = nixpkgs.lib // home-manager.lib;
    in
    rec {
      inherit lib;
      formatter = forAllSystems (system: nixpkgs.legacyPackages.${system}.nixpkgs-fmt);

      devShells = forAllSystems (system:
        let
          pkgs = import nixpkgs { system = system; };
          packages = [ pkgs.nix pkgs.colmena pkgs.just pkgs.git pkgs.home-manager pkgs.pass pkgs.nixos-rebuild ];
        in
        {
          default = pkgs.mkShell {
            nativeBuildInputs = packages;
            name = "colmena";
            #shellHook = "exec $SHELL";
          };
          hcloud = pkgs.mkShell {
            nativeBuildInputs = packages ++ [ pkgs.hcloud ];
            shellHook = ''
              export HCLOUD_TOKEN=$(pass services/hcloud/api_token)
              exec $SHELL
            '';
          };
        });

      colmena =
        let
          hosts = lib.genAttrs (builtins.attrNames (builtins.readDir ./hosts)) (name: { });
        in
        {
          meta = {
            description = "All my NixoS machines";
            specialArgs = {
              inherit inputs outputs;
              pkgs-unstable = import nixpkgs-unstable { system = "x86_64-linux"; };
            };
            nixpkgs = import nixpkgs { system = "x86_64-linux"; };
          };

          defaults = { lib, config, name, ... }: {
            imports = [ ./hosts/${name} ./profiles/base ];

            networking.hostName = name;
#            networking.domain = "cherrykitten.xyz";

            home-manager.extraSpecialArgs = {
              inherit inputs outputs;
              pkgs-unstable = import nixpkgs-unstable { system = "x86_64-linux"; };
            };
          };
        } // hosts;

      colmenaHive = inputs.colmena.lib.makeHive colmena;

      nixosConfigurations = { } // colmenaHive.nodes;

      packages.x86_64-linux.iso = self.nixosConfigurations.iso.config.system.build.isoImage;

      homeConfigurations =
        let
          pkgs = import nixpkgs { system = "x86_64-linux"; };
        in
        lib.genAttrs (builtins.attrNames (builtins.readDir ./users)) (name: lib.homeManagerConfiguration {
          inherit pkgs;
          modules = [ ./users/${name}/home.nix ];
          extraSpecialArgs = {
            inherit inputs outputs;
            pkgs-unstable = import nixpkgs-unstable { system = "x86_64-linux"; };
          };
        });
    };
}
