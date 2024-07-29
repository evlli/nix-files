{ config, pkgs, ... }: {
  services.desktopManager.plasma6.enable = true;  
  services.xserver = {
    enable = true;
    libinput.enable = true;

    xkb.layout = "de";
    xkb.variant = "us";
  };
  environment.systemPackages = with pkgs.kdePackages; [
    merkuro
    pim-sieve-editor
    kontact
    marknote
  ];
}
