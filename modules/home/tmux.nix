{ ... }: {
  programs.tmux = {
    enable = true;

    clock24 = true;
    shortcut = "a";
    keyMode = "vi";
    mouse = true;
    historyLimit = 50000;
    sensibleOnTop = false;

    extraConfig = ''
      set -g status-position top
      setw -g mode-keys vi

      bind . split-window -h
      bind - split-window -v

      bind C-p previous-window
      bind C-n next-window

      bind R source-file '~/.config/tmux/tmux.conf'

      set -g base-index 1

      set -g status-bg black
      set -g status-fg green

      set-option -sg escape-time 10
      set-option -g focus-events on

      set -s escape-time 0
      set -g display-time 4000
      set -g status-interval 5
      set -g default-terminal "screen-256color"
    '';
  };
}

