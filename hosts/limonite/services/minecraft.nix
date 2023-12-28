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
      SwitchTM = "2db23871-6f00-4281-ac11-54a8f83be565";
    };
  };
}
