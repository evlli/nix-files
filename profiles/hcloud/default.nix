{ modulesPath, config, ... }: {
  imports = [ (modulesPath + "/profiles/qemu-guest.nix") ];

  zramSwap.enable = true;
  boot.tmp.cleanOnBoot = true;
  boot.loader.grub.device = "/dev/sda";
  boot.initrd.availableKernelModules = [ "ata_piix" "uhci_hcd" "xen_blkfront" "vmw_pvscsi" ];
  boot.initrd.kernelModules = [ "nvme" ];

  deployment.targetHost = (builtins.elemAt config.networking.interfaces.eth0.ipv4.addresses 0).address;
  deployment.tags = [ "hcloud" "hetzner" "cloud"];
}
