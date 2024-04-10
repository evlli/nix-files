{ pkgs, ... }: {
  imports = [ 
    ./wayfire.nix 
    ./firefox.nix
    ./non-free.nix
  ];
  services.xserver = {
    enable = true;
    displayManager.sddm.enable = true;
    displayManager.sddm.wayland.enable = true;
    libinput.enable = true;

    xkb.layout = "de";
    xkb.variant = "us";
  };
  environment.systemPackages = with pkgs; [
    helvum
    wl-clipboard
  ];
  security.rtkit.enable = true;
  hardware.bluetooth.enable = true;
  services.printing.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
    jack.enable = true;
  };

  services.pipewire.wireplumber.configPackages = [
          (pkgs.writeTextDir "share/wireplumber/bluetooth.lua.d/51-bluez-config.lua" ''
                bluez_monitor.properties = {
                        ["bluez5.enable-sbc-xq"] = true,
                        ["bluez5.enable-msbc"] = true,
                        ["bluez5.enable-hw-volume"] = true,
                        ["bluez5.headset-roles"] = "[ hsp_hs hsp_ag hfp_hf hfp_ag ]"
                }
        '')
  ];

  fonts = {
    enableDefaultPackages = true;
    packages = [ pkgs.noto-fonts-emoji ];
  };
}
