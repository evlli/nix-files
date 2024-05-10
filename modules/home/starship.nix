{ lib, ... }: {
  programs.starship = {
    enable = true;
    settings = {
      format = lib.concatStrings [
        "$username$hostname:$directory$character"
      ];
      add_newline = false;
      username = {
        style_user = "#bb88aa";
        style_root = "red bold";
        format = "[$user]($style)";
        disabled = false;
        show_always = true;
      };

      hostname = {
        ssh_only = false;
        format = lib.concatStrings [
          "[$ssh_symbol](bold blue)"
          "@[$hostname](#9977bb)"
        ];
      };

      directory = {
        truncation_length = 4;
        truncation_symbol = "../";
        home_symbol = "~";
      };

      status = {
        format = lib.concatStrings [ "[\\[" "$common_meaning" "$signal_name" "$int" "\\]]" "($style)" ];
        map_symbol = true;
        disabled = false;
      };

      character = {
        success_symbol = "[❯](bold white)";
      };

      git_branch = {
          only_attached = true;
          format = "[$branch(:$remote_branch)]($style)";
      };
      git_commit = {
        only_detached = false;
      };

      nix_shell = {
        symbol ="❄️";
        };

      right_format = lib.concatStrings [
        "$git_branch"
        "$git_commit"
        "$git_state"
        "$git_metrics"
        "$git_status"
        "$docker_context"
        "$package"
        "$c"
        "$cmake"
        "$elixir"
        "$elm"
        "$erlang"
        "$fennel"
        "$golang"
        "$guix_shell"
        "$haskell"
        "$helm"
        "$java"
        "$kotlin"
        "$gradle"
        "$lua"
        "$nim"
        "$ocaml"
        "$perl"
        "$pulumi"
        "$purescript"
        "$python"
        "$raku"
        "$rlang"
        "$red"
        "$ruby"
        "$rust"
        "$scala"
        "$swift"
        "$terraform"
        "$vlang"
        "$vagrant"
        "$buf"
        "$nix_shell"
        "$meson"
        "$memory_usage"
        "$env_var"
        "$custom"
        "$sudo"
        "$line_break"
        "$jobs"
        "$battery"
        "$status"
        "$container"
      ];
    };
  };
}
