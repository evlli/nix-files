{ config, pgks, ... }:{
  programs.direnv.enable = true;
  programs.zsh = {
    enable = true;
    syntaxHighlighting.enable = true;
    enableCompletion = true;
    enableVteIntegration = true;
    autosuggestion.enable = true;
#    vteIntegration.enable = true;
    shellAliases = {
        ip = "ip --color=always";

      };

    oh-my-zsh = {
      enable = true;
      plugins = [
        "ansible"
        "colorize"
        "colored-man-pages"
        "docker-compose"
        "docker"
        "httpie"
        "lxd"
        "pass"
        "postgres"
        "python"
        "rust"
        "systemd"
        "tmux"
        "git"
        "sudo"
      ];

      theme = "alanpeabody";
      };
    };
  }
