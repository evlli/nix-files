{ inputs, pkgs, lib, config, ... }: {
  imports = [
#    ../../modules
    ../../users/root
    ../../users/evlli
    inputs.home-manager.nixosModules.home-manager
  ];
  nixpkgs.overlays = lib.attrValues inputs.self.overlays;
  nix.registry.nixpkgs.flake = inputs.nixpkgs;

  deployment.tags = [ pkgs.stdenv.hostPlatform.system ];
  deployment.targetUser = lib.mkDefault "evlli";
#  deployment.targetHost = lib.mkDefault config.networking.fqdn;
  deployment.targetPort = lib.mkDefault (lib.head config.services.openssh.ports);

  nix = {
    settings = {
      experimental-features = [ "nix-command" "flakes" ];
      trusted-users = [ "root" "@wheel" "evlli" ];
    };
    gc = {
      automatic = lib.mkDefault true;
      options = lib.mkDefault "--delete-older-than 7d";
    };
  };

  hardware.enableRedistributableFirmware = true;
  users.mutableUsers = false;
  home-manager.useGlobalPkgs = true;
  home-manager.useUserPackages = true;
  nixpkgs.config.allowUnfree = true;
  hardware.enableAllFirmware = true;

  time.timeZone = lib.mkDefault "Europe/Berlin";

  i18n.defaultLocale = lib.mkDefault "en_GB.UTF-8";
  console = {
    font = "Lat2-Terminus16";
    keyMap = lib.mkDefault "us";
    useXkbConfig = true;
  };

  networking.firewall.allowedTCPPorts = [ 22 ];

  services.openssh = {
    enable = true;
    settings = {
      PasswordAuthentication = false;
      KbdInteractiveAuthentication = false;
      PermitRootLogin = lib.mkDefault "no";
    };
  };

  programs.mosh.enable = true;
  services.iperf3.enable = true;
  services.iperf3.openFirewall = true;

  security.sudo.enable = false;
  security.sudo-rs.enable = true;
  security.sudo-rs.wheelNeedsPassword = lib.mkDefault false;

  networking.useNetworkd = true;
  networking.nftables.enable = true;
  networking.useDHCP = false;
  services.resolved.extraConfig = ''
    FallbackDNS=
    Cache=no-negative
  '';

  programs.zsh.enable = true;
  # Packages used on all systems
  environment.systemPackages = with pkgs; [
    bat
    bind.dnsutils
    fd
    file
    git
    gnupg
    htop
    jq
    mtr
    nmap
    openssl
    pinentry
    rsync
    tcpdump
    tmux
    wget
    whois
    wireguard-tools
    dnsmasq
    usbutils
    binwalk
    binutils
    flashrom
    ranger
  ];
}
