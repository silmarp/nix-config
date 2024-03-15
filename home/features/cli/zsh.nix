{ lib, pkgs, config, ... }: 

{
  programs.zsh = {
    enable = true;
    autosuggestion.enable = true;
    enableCompletion = true;
    syntaxHighlighting.enable = true;
    history.save = 500;
    shellAliases = {
	    grep="grep --color";
      nd="nix develop -c $SHELL";
    };
    localVariables = {
      EDITOR = "nvim";
    };
  };
}
