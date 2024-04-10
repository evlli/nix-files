{ config, pkgs, ...}: {
  programs.firefox = {
      enable = true;
      nativeMessagingHosts.packages = with pkgs; [ passff-host ];
      
    };
}
