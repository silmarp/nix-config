{pkgs, lib, ...}:

{
  users.users.git = {
    isSystemUser = true;
    group = "git";
    home = "/var/lib/git-server";
    createHome = true;
    shell = lib.getExe' pkgs.git "git-shell"; 
    openssh.authorizedKeys.keys = [ (builtins.readFile ../../../home/ssh.pub) ];
  };

  users.groups.git = {};

  services.openssh = {
    enable = true;
    extraConfig = ''
      Match user git
        AllowTcpForwarding no
        AllowAgentForwarding no
        PasswordAuthentication no
        PermitTTY no
        X11Forwarding no
    '';
  };
}

