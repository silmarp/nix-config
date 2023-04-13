{ lib, pkgs, config, ... }: 

{

  # TODO move starship to it's own flake
  programs.starship = {
      enable = true;
      enableZshIntegration = true;

      settings = {
        format = "$all";
	      add_newline = false;
      };
  };

  programs.zsh = {
    enable = true;
    enableAutosuggestions = true;
    enableCompletion = true;
    enableSyntaxHighlighting = true;
    history.save = 500;
    shellAliases = {
      ls="ls --color";
	    grep="grep --color";
    };
  };
}
