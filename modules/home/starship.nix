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
        "$vcsh"
        "$fossil_branch"
        "$git_branch"
        "$git_commit"
        "$git_state"
        "$git_metrics"
        "$git_status"
        "$hg_branch"
        "$pijul_channel"
        "$docker_context"
        "$package"
        "$c"
        "$cmake"
        "$cobol"
        "$daml"
        "$dart"
        "$deno"
        "$dotnet"
        "$elixir"
        "$elm"
        "$erlang"
        "$fennel"
        "$golang"
        "$guix_shell"
        "$haskell"
        "$haxe"
        "$helm"
        "$java"
        "$julia"
        "$kotlin"
        "$gradle"
        "$lua"
        "$nim"
        "$nodejs"
        "$ocaml"
        "$opa"
        "$perl"
        "$php"
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
        "$zig"
        "$buf"
        "$nix_shell"
        "$conda"
        "$meson"
        "$spack"
        "$memory_usage"
        "$aws"
        "$gcloud"
        "$openstack"
        "$azure"
        "$env_var"
        "$crystal"
        "$custom"
        "$sudo"
        "$cmd_duration"
        "$line_break"
        "$jobs"
        "$battery"
        "$time"
        "$status"
        "$os"
        "$container"
        "$shell"
      ];
    };
  };
}
