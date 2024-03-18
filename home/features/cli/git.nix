{ ... }:

{
  programs.git = {
    enable = true;
    diff-so-fancy.enable = true;
    userName = "Silmar";
    userEmail = "silmarjr2@gmail.com";
    ignores = [ "result" ];
    extraConfig = {
      init.defaultBranch = "main";
    };
    aliases = {
      graph = "log --graph";
      st = "status";
      p = "pull";
    };
  };
}
