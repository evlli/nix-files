{ pkgs, lib, config, ... }:

{
  imports = [
    ./importable.nix
  ];
  e.sops.secrets."all/users/evlli_passwd_hash".neededForUsers = true;
  users.users.evlli.hashedPasswordFile = lib.mkDefault config.sops.secrets."all/users/evlli_passwd_hash".path;
}

