{ modulesPath, pkgs, ... }:
{
  imports = [
    "${modulesPath}/installer/cd-dvd/installation-cd-graphical-plasma5.nix"
  ];

  # Enables copy / paste when running in a KVM with spice.
  services.spice-vdagentd.enable = true;

  users.users.nixos.shell = pkgs.fish;
  programs.fish.enable = true;

  environment.systemPackages = with pkgs; [
    mkpasswd
    nixpkgs-fmt
    neovim-unwrapped
    xclip
  ];

  home-manager.users.nixos = {
    imports = [
      ../../modules/home/foot.nix
    ];
    home.stateVersion = "23.11";

  };
  # Use faster squashfs compression
  isoImage.squashfsCompression = "gzip -Xcompression-level 1";
}
