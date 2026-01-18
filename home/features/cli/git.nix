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
    ];
    extraConfig = {
      init.defaultBranch = "main";
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
