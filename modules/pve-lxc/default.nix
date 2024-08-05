{ lib, config, modulesPath, ... }:
let
  cfg = config.hardware.lxc-in-pve;
in {
  imports = [
    (modulesPath + "/virtualisation/proxmox-lxc.nix")
  ];

  options.hardware.lxc-in-pve = with lib; {
    enable = mkEnableOption "lxc containers";
    vmid = mkOption {
      type = types.int;
    };
  };
  config = lib.mkIf cfg.enable {
    deployment.targetHost = "100.64.0.${toString cfg.vmid}";
  };
}
