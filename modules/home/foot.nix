{ ... }:
{
  programs.foot = {
    enable = true;
    settings = {
      main = {
        font = "monospace:size=8";
        dpi-aware = "yes";
        initial-window-size-pixels = "1920x1080";
      };

      bell.visual = "yes";

      # colors taken from https://codeberg.org/dnkl/foot/src/branch/master/themes/catppuccin
      cursor.color = "1A1826 D9E0EE";
      colors = {
        foreground = "D9E0EE";
        background = "1E1D2F";
        regular0 = "6E6C7E";
        regular1 = "F28FAD";
        regular2 = "ABE9B3";
        regular3 = "FAE3B0";
        regular4 = "96CDFB";
        regular5 = "F5C2E7";
        regular6 = "89DCEB";
        regular7 = "D9E0EE";
        bright0 = "988BA2";
        bright1 = "F28FAD";
        bright2 = "ABE9B3";
        bright3 = "FAE3B0";
        bright4 = "96CDFB";
        bright5 = "F5C2E7";
        bright6 = "89DCEB";
        bright7 = "D9E0EE";
      };
    };
  };
}
