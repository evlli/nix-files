{ config, modulesPath, ... }:
let
  vmid = 106;
in {
  imports = [
    (modulesPath + "/virtualisation/proxmox-lxc.nix")
  ];

  services.navidrome = {
    enable = true;
    settings = {
      MusicFolder = "/navimedia/music";
    };
  };

  services.nginx = {
      enable = true;
      recommendedProxySettings = true;
      recommendedTlsSettings = true;
      # other Nginx options
      virtualHosts."sonic.evl.li" =  {
        enableACME = true;
        forceSSL = true;
        locations."/" = {
          proxyPass = "http://${config.services.navidrome.settings.Address}:${toString config.services.navidrome.settings.Port}";
          proxyWebsockets = true; # needed if you need to use WebSocket
          extraConfig =
            # required when the target is also TLS server with multiple hosts
            "proxy_ssl_server_name on;" +
            # required when the server wants to use HTTP Authentication
            "proxy_pass_header Authorization;"
            ;
        };
      };
  };

  security.acme = {
    acceptTerms = true;   
    certs = { 
      "sonic.evl.li".email = "acme@evl.li"; 
    }; 
  };

  networking.firewall.allowedTCPPorts = [ 80 443 ];
  deployment.targetHost = "100.64.0.${toString vmid}";
#  deployment.targetUser = "root";
#  networking.hostId = (builtins.substring 0 8 (builtins.readFile "/etc/machine-id"));
  networking.hostName = "sonic";


  system.stateVersion = "23.11"; # Did you read the comment?
}

