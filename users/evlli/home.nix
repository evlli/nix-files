{ ... }: {
  imports = [ 
    ./git.nix
    ./ssh.nix
    ./zsh.nix
    ./nvim/default.nix
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
    XDG_DESKTOP_DIR = "$HOME/persist/desktop";
    XDG_DOWNLOAD_DIR = "$HOME/scratchpad/downloads";
    XDG_DOCUMENTS_DIR =  "$HOME/persist/documents";
    XDG_MUSIC_DIR = "$HOME/persist/media/music";
    XDG_PICTURES_DIR = "$HOME/persist/media/pics";
    XDG_TEMPLATES_DIR = "$HOME/persist/templates";
    XDG_VIDEOS_DIR = "$HOME/media/videos";
  };

  home.file = {
    ".ssh/card.pub".text = "ecdsa-sha2-nistp384 AAAAE2VjZHNhLXNoYTItbmlzdHAzODQAAAAIbmlzdHAzODQAAABhBLOrW0Z970f4RbXRYuXNKAkulKLyVApQiqmW8Mk6RWr5V2mJ7wQlsKsFcUPk63WLF5rJAiWo4hqneqLYFFQEf9fUWWNs2K9LPGLaYPfYgJLCNYxx0pVuMEEsMt+IPV24kQ== openpgp:0x4D3B3663";
  };
}
