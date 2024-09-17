{ ... }:
{
  programs.starship = {
      enable = true;
      enableZshIntegration = true;
      enableNushellIntegration = true;

      settings = {
        format = "$all";
	      add_newline = false;
      };
  };
}
