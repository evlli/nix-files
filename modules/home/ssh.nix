{ ... }: {
  programs.ssh = {
    enable = true;
    matchBlocks = {
      initramfs = {
        host = 192.168.69.69;
        user = "root";
        proxyJump = "evlli@router-home.1e2a.de,root@10.0.13.12";
      };
      "*" = {
        sendEnv = [ "PS1" ];
        identityFile = [ "~/.ssh/card.pub" ];
        identidiesOnly = true;
      };
    };
  };
  home.file = {
    ".ssh/card.pub".text = "ecdsa-sha2-nistp384 AAAAE2VjZHNhLXNoYTItbmlzdHAzODQAAAAIbmlzdHAzODQAAABhBLOrW0Z970f4RbXRYuXNKAkulKLyVApQiqmW8Mk6RWr5V2mJ7wQlsKsFcUPk63WLF5rJAiWo4hqneqLYFFQEf9fUWWNs2K9LPGLaYPfYgJLCNYxx0pVuMEEsMt+IPV24kQ== openpgp:0x4D3B3663";
  };
}
