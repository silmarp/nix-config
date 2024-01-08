{pkgs, config, ...}:

let 
  ifExist = groups: builtins.filter (group: builtins.hasAttr group config.users.groups) groups;
in
{
  users.users.silmar = {
    isNormalUser = true;
    shell = pkgs.zsh;
    description = "Silmar";
    extraGroups = [
      "wheel" # Enable ‘sudo’ for the user.
      "video" # Enable changing video settings
      "input"
    ] ++ ifExist [
      "minecraft"
      "docker"
      "libvirtd"
      "networkmanager"
    ]; 

    openssh.authorizedKeys.keys = [ (builtins.readFile ../../../../home/ssh.pub) ];
  };

  users.defaultUserShell = pkgs.zsh;

  programs.zsh.enable = true;

}
