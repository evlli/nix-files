{ pkgs, modulesPath, ... }:

{
  imports = [
    (modulesPath + "/virtualisation/proxmox-lxc.nix")
  ];

  deployment.keys."nextcloud-admin" = {
    keyCommand = [ "pass" "infra/services/nextcloud/admin" ];
    group = "nextcloud";
    user = "nextcloud";
    destDir = "/etc/";
    permissions = "0666";
  };

  services.nextcloud = {
    enable = true;
    package = pkgs.nextcloud29;
    hostName = "stormy.evl.li";
    configureRedis = true;
    https = true;
    database.createLocally = true;
    config = {
      dbtype = "pgsql";
      adminpassFile = "/etc/nextcloud-admin";
    };
#    phpExtraExtensions = all: [ all.exif ];
    extraApps = {
      inherit (pkgs.nextcloud29Packages.apps) contacts calendar tasks maps music memories;
      oidc_login = pkgs.fetchNextcloudApp {
        sha256 = "sha256-EVHDDFtz92lZviuTqr+St7agfBWok83HpfuL6DFCoTE=";
        url = "https://github.com/pulsejet/nextcloud-oidc-login/releases/download/v3.1.1/oidc_login.tar.gz";
        license = "gpl3";
      };
      files_3dmodelviwer = pkgs.fetchNextcloudApp {
        sha256 = "sha256-HlqO7xlMSRGgBtwi0t5oz5v7iw0zTSHysc9wGVRwGZI=";
        url = "https://github.com/WARP-LAB/files_3dmodelviewer/releases/download/v0.0.14/files_3dmodelviewer.tar.gz";
        license = "gpl3";
      };
      snappymail = pkgs.fetchNextcloudApp {
        sha256 = "sha256-HlqO7xlMSRGgBtwi0t5oz5v7iw0zTSHysc9wGVRwGZI=";
        url = "https://snappymail.eu/repository/nextcloud/snappymail-2.36.4-nextcloud.tar.gz";
        license = "gpl3";
      };
#      collectives = pkgs.fetchNextcloudApp {
#        sha256 = "sha256-nor19hna+s1bBq9rH93pSSjxt/x3r057FZfyeiT4vAE=";
#        url = "https://github.com/nextcloud/collectives/releases/download/v2.12.0/collectives-2.12.0.tar.gz"
#        license = "gpl3";
#      };
#      metadata = pkgs.fetchNextcloudApp {
#        sha256 = "sha256-nor19hna+s1bBq9rH93pSSjxt/x3r057FZfyeiT4vAE=";
#        url = "https://github.com/gino0631/nextcloud-metadata/releases/download/v0.20.0/metadata.tar.gz";  
#        license = "gpl3";
#      };
    };
    extraAppsEnable = true;
  };

  services.nginx.virtualHosts."stormy.evl.li" = {
    forceSSL = true;
    enableACME = true;
  };

  security.acme = {
    acceptTerms = true;   
    certs = { 
      "stormy.evl.li".email = "acme@evl.li"; 
    }; 
  };

  networking.firewall.allowedTCPPorts = [ 80 443 ];
  deployment.targetHost = "100.64.0.109";
  networking.hostId = "5445e34f";
  networking.hostName = "cloudy";


  system.stateVersion = "23.11"; # Did you read the comment?
}

