{ config, pkgs, lib, ... }:
{

  users.users.evlli = {
    isNormalUser = true;
    extraGroups = [ "networkmanager" "wheel" "docker" "libvirtd" "realtime" "rtkit" "audio" "dialout" ];
    description = "Evelyn Alicke";
    shell = pkgs.zsh;
    openssh.authorizedKeys.keys = [ "ecdsa-sha2-nistp384 AAAAE2VjZHNhLXNoYTItbmlzdHAzODQAAAAIbmlzdHAzODQAAABhBLOrW0Z970f4RbXRYuXNKAkulKLyVApQiqmW8Mk6RWr5V2mJ7wQlsKsFcUPk63WLF5rJAiWo4hqneqLYFFQEf9fUWWNs2K9LPGLaYPfYgJLCNYxx0pVuMEEsMt+IPV24kQ== openpgp:0x4D3B3663" ];
  };
#  environment.systemPackages = with pkgs; [
#      pass-wayland
#      passff-host
#      thunderbird
#      syncthing
#    ];

#  environment.variables = {
#    LV2_PATH = "~/.lv2:/nix/var/nix/profiles/default/lib/lv2:/var/run/current-system/sw/lib/lv2";
#    VST_PATH = "~/.vst:/nix/var/nix/profiles/default/lib/vst:/var/run/current-system/sw/lib/vst";
#    LXVST_PATH = "~/.lxvst:/nix/var/nix/profiles/default/lib/lxvst:/var/run/current-system/sw/lib/lxvst";
#    LADSPA_PATH = "~/.ladspa:/nix/var/nix/profiles/default/lib/ladspa:/var/run/current-system/sw/lib/ladspa";
#    DSSI_PATH = "~/.dssi:/nix/var/nix/profiles/default/lib/dssi:/var/run/current-system/sw/lib/dssi";
#  };

  home-manager.users.evlli = import ./home.nix;
}
