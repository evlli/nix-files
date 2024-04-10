{ ... }: {
  imports = [ 
    ../../modules/home 
#    .zsh.nix
    ];

  home.stateVersion = "23.11"; # Please read the comment before changing.

  home.sessionVariables = {
    EDITOR = "nvim";
  };

}
