{ ... }: {
  imports = [ 
    ../../modules/home 
  ];

  programs.git = {
    userName = "Evelyn Alicke";
    userEmail = "dev@evl.li";
    signing.key = "0x8092413A3F6DD75F";
    signing.signByDefault = true;
  };
  home.username = "evlli";
  home.homeDirectory = "/home/evlli";
  home.stateVersion = "23.11"; # Please read the comment before changing.
  home.file."/.config" = {
      source = ../../legacy_dotfiles;
      recursive = true;
    };
  home.sessionVariables = {
    EDITOR = "nvim";
  };

  programs.gpg = {
    enable = true;
    publicKeys = [
      {
        source = "/home/evlli/.password-store/.pubkeys/id@evl.li.pub"; # this key is the root of all trust and is signed by all other keys
        trust = "ultimate";
      }
    ];
  };
}
