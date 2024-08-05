{ pkgs, config, ... }:
{
  hardware.lxc-in-pve = {
    enable = true;
    vmid = 106;
  };
  services.navidrome = {
    enable = true;
    settings = {
      MusicFolder = "/navimedia/music";
    };
  };

  environment.systemPackages = with pkgs; [ python312  python312Packages.pip ];

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
  networking.hostName = "sonic";

  system.stateVersion = "23.11"; # Did you read the comment?
}

