{ pkgs, ... }: {
  imports = [ 
#    ./wayfire.nix 
    ./kde.nix
    ./firefox.nix
    ./non-free.nix
  ];
  services = {
    displayManager.sddm.enable = true;
    displayManager.sddm.wayland.enable = true;
    libinput.enable = true;
  };
  services.xserver = {
    xkb.layout = "de";
    xkb.variant = "us";
  };
  environment.systemPackages = with pkgs; [
    helvum
    wl-clipboard
    pw-volume
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
    raopOpenFirewall = true;
  };
  
  programs.gnupg.agent = {
      enable = true;
      enableSSHSupport = true;
      enableExtraSocket = true;
    };
  services.pcscd.enable = true;

  users = {
    groups.realtime = { };
  };
  services.udev.extraRules = ''
    KERNEL=="cpu_dma_latency", GROUP="realtime"
  '';
  security.pam.loginLimits = [
    {
      domain = "@realtime";
      type = "-";
      item = "rtprio";
      value = 98;
    }
    {
      domain = "@realtime";
      type = "-";
      item = "memlock";
      value = "unlimited";
    }
    {
      domain = "@realtime";
      type = "-";
      item = "nice";
      value = -11;
    }
  ];


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
