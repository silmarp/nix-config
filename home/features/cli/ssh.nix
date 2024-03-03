{ config, ... }:

{
  services.ssh-agent.enable = true;

  programs.ssh = {
    enable = true;
    matchBlocks = {
      net = {
        host = "*";
        forwardAgent = true;
        identityFile = "${config.home.homeDirectory}/.ssh/ssh";
      };
    };
    addKeysToAgent = "30m";
  };
}
