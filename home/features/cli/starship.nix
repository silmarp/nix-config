{ ... }:
{
  programs.starship = {
      enable = true;
      enableZshIntegration = true;

      settings = {
        format = "$all";
	      add_newline = false;
      };
  };
}
