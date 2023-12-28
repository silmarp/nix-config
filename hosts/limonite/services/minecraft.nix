{ pkgs, ... }:

{
  services.minecraft-server = {
    enable = true;
    # 1.20.2
    package = pkgs.minecraft-server;
    #dataDir = "path ?";
    declarative = true;
    eula = true; # required
    serverProperties = {
       server-port = 43000;
       /*
       difficulty = 3;
       gamemode = 1;
       max-players = 5;
       motd = "NixOS Minecraft server!";
       white-list = true;
       enable-rcon = true;
       "rcon.password" = "hunter2";
       */
    };
    whitelist = {
      SwitchSilver = "da246bf3-b644-42a2-bdd3-31e8a7f52bbc";
    };
  };
}
