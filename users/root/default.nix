{ pkgs, lib, ... }:
{
  deployment.keys."root_password_hash" = {
    keyCommand = [ "pass" "infra/hosts/nyxia/users/root" ];
  };

  users.users.root = {
    shell = pkgs.zsh;
    hashedPasswordFile = lib.mkDefault "/run/keys/root_password_hash";
  };

  home-manager.users.root = import ./home.nix;
}
