{ pkgs, ... }: {
    programs.wayfire = {
        enable = true;
        plugins = with pkgs.wayfirePlugins; [
          wcm
          wf-shell
          wayfire-plugins-extra
        ];
      };
    environment.systemPackages = with pkgs; [
      kitty
      wofi
      eww
      mako
      wdisplays
      kanshi
      wev
    ];
  }
