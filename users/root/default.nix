{ pkgs, lib, ... }:
{
  users.users.root = {
    shell = pkgs.zsh;
  };

  home-manager.users.root = import ./home.nix;
}
