{ config, pgks, home-manager, ... }:{
  programs.direnv.enable = true;
  programs.zsh = {
    enable = true;
    syntaxHighlighting.enable = true;
    autosuggestions.enable = true;
    enableCompletion = true;
    vteIntegration.enable = true;
    shellAliases = {
        ip = "ip --color=always";

      };
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

      };
  }
