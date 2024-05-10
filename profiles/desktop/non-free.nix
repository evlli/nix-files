{lib, pkgs, ...}: {
  nixpkgs.config.allowUnfreePredicate = pkg: builtins.elem (lib.getName pkg) [
   "spotify"
   "reaper"
  ];
  environment.systemPackages = with pkgs; [
    spotify
    reaper
    yabridge
    yabridgectl
#    wineWowPackages.stable
    wineWowPackages.staging
    winetricks
    carla
    cardinal
  ];
}
