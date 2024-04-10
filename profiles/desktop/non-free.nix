{lib, pkgs, ...}: {
  nixpkgs.config.allowUnfreePredicate = pkg: builtins.elem (lib.getName pkg) [
   "spotify"
  ];
  environment.systemPackages = with pkgs; [
    spotify
  ];
}
