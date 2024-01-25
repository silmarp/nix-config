{ config, ... }:

{
  services.ssh-agent.enable = true;

  programs.ssh = {
    enable = true;
    matchBlocks = {
      net = {
        host = "*";
        forwardAgent = true;
      };
    };
    addKeysToAgent = "ask";
  };
}
