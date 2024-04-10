{ config, pkgs, ... }: {
  services.desktopManager.plasma6.enable = true;  
  services.xserver = {
    enable = true;
    libinput.enable = true;

    xkb.layout = "us";
    xkb.variant = "de";
  };
}
