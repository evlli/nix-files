{ lib, pkgs, inputs, ... }: {
  imports = [
    ../../users/root
    ../../users/evlli
    inputs.home-manager.nixosModules.home-manager
  ];

  deployment.tags = [ pkgs.stdenv.hostPlatform.system ];
  deployment.targetUser = lib.mkDefault "evlli";

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

  users.mutableUsers = false;
  home-manager.useGlobalPkgs = true;
  home-manager.useUserPackages = true;
  nixpkgs.config.allowUnfree = true;
  hardware.enableAllFirmware = true;

  time.timeZone = lib.mkDefault "Europe/Berlin";

  i18n.defaultLocale = lib.mkDefault "en_US.UTF-8";
  console = {
    font = "Lat2-Terminus16";
    keyMap = lib.mkDefault "de";
    useXkbConfig = true;
  };

  networking.firewall.allowedTCPPorts = [ 22 ];

  services.openssh = {
    enable = true;
    extraConfig = ''
      StreamLocalBindUnlink yes
    '';
    settings = {
      PermitRootLogin = lib.mkOverride 999 "no";
      PasswordAuthentication = false;
      Macs = [
        "hmac-sha2-512"
        "hmac-sha2-256"
      ];
      KexAlgorithms = [
        "sntrup761x25519-sha512@openssh.com"
        "curve25519-sha256"
        "curve25519-sha256@libssh.org"
        "diffie-hellman-group-exchange-sha256"
      ];
      Ciphers = [
        "aes256-gcm@openssh.com"
        "aes128-gcm@openssh.com"
        "aes256-ctr"
        "aes192-ctr"
        "aes128-ctr"
      ];
    };
  };

  security = {
    sudo = {
      enable = true;
      wheelNeedsPassword = false;
      keepTerminfo = true;
    };

    acme = {
      acceptTerms = true;
      defaults.email = "acme@evl.li";
    };
  };

  services.fail2ban = {
    enable = lib.mkDefault true;
    maxretry = 5;
  };
  services.udev.packages = with pkgs; [ libu2f-host yubikey-personalization ];

  programs.gnupg.agent = {
    enable = true;
    enableSSHSupport = true;
    enableExtraSocket = true;
  };

  services.pcscd.enable = true;

  virtualisation.vmVariant = {
    # following configuration is added only when building VM with build-vm
    virtualisation = {
      memorySize = 8192;
      cores = 6;
      graphics = true;
    };
    users.users.evlli.hashedPassword = "";
  };

#  programs.fish.enable = true;
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
  ];
}
