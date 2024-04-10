{ pkgs, ... }: {
  imports = [
    ./hardware-configuration.nix
    ../../profiles/desktop
    ./volumes.nix
  ];

  deployment.allowLocalDeployment = true;

  services.logrotate.checkConfig = false;
  boot.initrd.systemd.enable = true;
  networking.hostId = "8425e349";
  boot.loader.systemd-boot.enable = true;

  networking.networkmanager.enable = true;
  system.stateVersion = "23.11"; # Did you read the comment?
}
