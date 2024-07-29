{ self, ... }: rec {

  flake.overlays.default = final: prev:
    let
      pseudoPkgs = (perSystem { pkgs = { }; }).packages;
    in
    builtins.mapAttrs (name: _: self.packages.${final.system}.${name}) pseudoPkgs;

  perSystem = { pkgs, ... }: {
    packages = {
      ot-cryptid = pkgs.callPackage ./ot-cryptid { };
    };
  };
}

