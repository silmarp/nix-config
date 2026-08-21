{ ... }:

{
  programs.git = {
    enable = true;
    ignores = [ 
      "result"
      ".direnv"
      ".helix"
      ".envrc"
      ".nix"
    ];
    settings = {
      user = {
        name = "Silmar";
        email = "silmarjr2@gmail.com";
      };

      init.defaultBranch = "main";
      core.editor = "hx";

      aliases = {
        graph = "log --graph";
        st = "status";
        p = "pull";
      };
    };
  };

  programs.diff-so-fancy = {
    enable = true;
    enableGitIntegration = true;
  };
}
