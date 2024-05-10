{ pkgs, lib, inputs, ... }: {
  imports = [
    inputs.lanzaboote.nixosModules.lanzaboote
    ./hardware-configuration.nix
    ../../profiles/desktop
    ./volumes.nix
  ];

  deployment.allowLocalDeployment = true;

  environment.systemPackages = with pkgs; [ sbctl modem-manager-gui fwupd ];

  services.resolved = {
      enable = true;
      dnssec = "true";
    };

  services.fwupd.enable = true;
  hardware.usb-modeswitch.enable = true;
  services.logrotate.checkConfig = false;
  boot.initrd.systemd.enable = true;
  networking.hostId = "8425e349";
  boot.loader.systemd-boot.enable = lib.mkForce false;
  boot.lanzaboote = {
      enable = true;
      pkiBundle = "/etc/secureboot";
    };


  networking.networkmanager.enable = true;
  system.stateVersion = "23.11"; # Did you read the comment?
}
