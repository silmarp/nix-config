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
    extraConfig = /* nu */ ''
      let carapace_completer = {|spans|
        carapace $spans.0 nushell $spans | from json
      }
      $env.config = {
        show_banner: false,
        completions: {
          case_sensitive: false # case-sensitive completions
          quick: true    # set to false to prevent auto-selecting completions
          partial: true    # set to false to prevent partial filling of the prompt
          algorithm: "fuzzy"    # prefix or fuzzy
        }
      } 
    '';
  };
  
  programs.carapace = {
    enable = true;
    enableNushellIntegration = true;
  };
}
