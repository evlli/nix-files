{lib, pkgs, ...}: {
  nixpkgs.config.allowUnfreePredicate = pkg: builtins.elem (lib.getName pkg) [
   "spotify"
   "reaper"
  ];
  networking.firewall.allowedTCPPorts = [ 57621 ]; # spotify file sync
  networking.firewall.allowedUDPPorts = [ 5353 ]; # spotify connect
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
