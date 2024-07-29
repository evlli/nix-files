{ config, lib, ... }:

{

  boot.initrd.availableKernelModules = [ "nvme" "ehci_pci" "xhci_pci" "usb_storage" "sd_mod" "rtsx_pci_sdmmc" ];
  boot.initrd.luks.devices.cryptroot.device = "/dev/nvme0n1p2";
  boot.initrd.kernelModules = [ ];
  boot.kernelModules = [ "kvm-amd" ];
  boot.extraModulePackages = [ ];

  fileSystems."/" =
    { device = "nyxia-rpool/root";
      fsType = "zfs";
    };

  fileSystems."/home" =
    { device = "nyxia-rpool/home";
      fsType = "zfs";
    };

  fileSystems."/nix" =
    { device = "nyxia-rpool/nix";
      fsType = "zfs";
    };

  fileSystems."/nix/store" =
    { device = "nyxia-rpool/nix/store";
      fsType = "zfs";
    };

  fileSystems."/boot" =
    { device = "/dev/disk/by-uuid/D811-468F";
      fsType = "vfat";
    };

  swapDevices =
    [ { device = "/dev/disk/by-uuid/6a7313fa-b601-4560-ac73-54745b088ca9"; }
    ];

  nixpkgs.hostPlatform = lib.mkDefault "x86_64-linux";
  hardware.cpu.amd.updateMicrocode = lib.mkDefault config.hardware.enableRedistributableFirmware;
}
