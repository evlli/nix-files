{ pkgs, lib, ... }:
{
  deployment.keys."evlli_password_hash" = {
    keyCommand = [ "pass" "infra/hosts/nyxia/users/evlli" ];
  };

  users.users.evlli = {
    isNormalUser = true;
    extraGroups = [ "networkmanager" "wheel" "docker" "libvirtd" ];
    description = "Evelyn Alicke";
    shell = pkgs.zsh;
    openssh.authorizedKeys.keys = [ "ecdsa-sha2-nistp384 AAAAE2VjZHNhLXNoYTItbmlzdHAzODQAAAAIbmlzdHAzODQAAABhBLOrW0Z970f4RbXRYuXNKAkulKLyVApQiqmW8Mk6RWr5V2mJ7wQlsKsFcUPk63WLF5rJAiWo4hqneqLYFFQEf9fUWWNs2K9LPGLaYPfYgJLCNYxx0pVuMEEsMt+IPV24kQ== openpgp:0x4D3B3663" ];
    hashedPasswordFile = lib.mkDefault "/run/keys/evlli_password_hash";
  };
  environment.systemPackages = with pkgs; [
      pass-wayland
      passff-host
    ];

  home-manager.users.evlli = import ./home.nix;
}
