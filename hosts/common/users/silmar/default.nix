{pkgs, ...}:

{

  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users.silmar = {
    isNormalUser = true;
    shell = pkgs.zsh;
    description = "Silmar";
    extraGroups = [
      "wheel" # Enable ‘sudo’ for the user.
      "video" # Enable changing video settings
      "input"
      "docker"
      "libvirtd"
      
      "networkmanager"
    ]; 

    openssh.authorizedKeys.keys = [ (builtins.readFile ../../../../home/ssh.pub) ];
  };

  users.defaultUserShell = pkgs.zsh;

  programs.zsh.enable = true;

}
