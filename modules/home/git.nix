{ ... }: {
  programs.git = {
    enable = true;
    extraConfig = {
      init = { defaultBranch = "main"; };
      core = { editor = "nvim"; };
      pull.rebase = true;
      push.autoSetupRemote = true;
    };
    aliases = {
      br = "branch --format='%(HEAD) %(color:yellow)%(refname:short)%(color:reset) - %(contents:subject) %(color:green)(%(committerdate:relative)) [%(authorname)]' --sort=-committerdate";
      del = "branch -D";
      pfusch = "push --force-with-lease";
      putch = "push --force";
      r = "rebase";
      ri = "rebase -i";
      s = "status";
      sw = "switch";
    };
  };
}
