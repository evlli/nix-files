{ home-manager , ... }: {
  programs.ssh = {
    enable = true;
    matchBlocks = {
      initramfs = {
        host = "192.168.69.69";
        user = "root";
        proxyJump = "evlli@router-home.1e2a.de,root@10.0.13.12";
      };
      "100.64.0.10 10.0.13.69" = {
        user = "root";
        forwardAgent = true;
        };
      "100.64.0.*" = {
        proxyJump = "evlli@ingress.evl.li,root@100.64.0.10";
      };
      "*" = {
        sendEnv = [ "PS1" "COLORFGBF" "COLORTERM" ];
      };
    };
  };
}
