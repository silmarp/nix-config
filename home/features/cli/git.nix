{ ... }:

{
  programs.git = {
    enable = true;
    diff-so-fancy.enable = true;
    userName = "Silmar";
    userEmail = "silmarjr2@gmail.com";
    ignores = [ 
      "result"
      ".direnv"
      ".helix"
      ".envrc"
      ".nix"
    ];
    extraConfig = {
      init.defaultBranch = "main";
      core.editor = "hx";
    };
    aliases = {
      graph = "log --graph";
      st = "status";
      p = "pull";
    };
  };

  programs.diff-so-fancy = {
    enable = true;
    enableGitIntegration = true;
  };
}
