{ ... }: {

  programs.ssh = {
    enable = true;
    matchBlocks = {
      eevee = {
        host = "eevee ee.vee";
        hostname = "192.168.0.3";
        user = "root";
        identityFile = "~/.ssh/yubikey.pub";
        identitiesOnly = true;
      };

      "social.cherrykitten.dev" = {
        host = "social social.cherrykitten.dev";
        hostname = "social.cherrykitten.dev";
        user = "sammy";
        identityFile = "~/.ssh/yubikey.pub";
        identitiesOnly = true;
      };

      "git.cherrykitten.dev" = {
        host = "git.cherrykitten.dev";
        user = "git";
        identityFile = "~/.ssh/yubikey.pub";
        identitiesOnly = true;
      };

      "ocelot" = {
        host = "ocelot";
        hostname = "128.140.109.125";
        identityFile = "~/.ssh/yubikey.pub";
        identitiesOnly = true;
        remoteForwards = [
          {
            bind.address = "/run/user/1000/gnupg/S.gpg-agent";
            host.address = "/run/user/1000/gnupg/S.gpg-agent.extra";
          }
        ];
      };

      "chat.cherrykitten.dev" = {
        host = "chat.cherrykitten.dev chat";
        hostname = "chat.cherrykitten.dev";
        user = "root";
        identityFile = "~/.ssh/yubikey.pub";
        identitiesOnly = true;
      };

      github = {
        host = "gh github github.com";
        user = "git";
        identityFile = [ "~/.ssh/yubikey.pub" "~/.ssh/yubikey_work.pub" ];
        identitiesOnly = true;
      };
    };
  };

  home.file = {
    ".ssh/yubikey.pub".text = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIJZyQSZw+pExsx2RXB+yxbaJGB9mtvudbQ/BP7E1yKvr openpgp:0x6068FEBB";
    ".ssh/yubikey_work.pub".text = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIOtNy5xYn2i1sXnjFmeYu1B87d2JLXcFEGUnmjbi557L openpgp:0x1E9BE982";
  };
}
