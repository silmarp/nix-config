{ pkgs, ... }:

{
  programs.nushell = {
    enable = true;
    package = pkgs.nushell;
    shellAliases = {
      nd = "nix develop -c $env.SHELL";
    };
    envFile.text = ''
      $env.EDITOR = 'nvim'
    '';
  };
  
  programs.carapace = {
    enable = true;
    enableNushellIntegration = true;
  };
}
