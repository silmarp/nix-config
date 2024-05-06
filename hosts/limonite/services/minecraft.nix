{ pkgs, inputs, ... }:

let
  java8 = pkgs.jre8;
in
{
  imports = [ inputs.modded-minecraft.module ];

  services.modded-minecraft-servers = {
    eula = true;

    instances = {
      # Modpack https://www.curseforge.com/minecraft/modpacks/nomi-ceu
      # Version 1.7-alpha-2a
      nomifactory = {
        enable = true;

        # does not build without this option
        rsyncSSHKeys = [
          (builtins.readFile ../../../home/ssh.pub)
        ];

        jvmMaxAllocation = "10G";
        jvmInitialAllocation = "5G";
        jvmPackage = java8;
        serverConfig = {
          server-port = 43000;
          difficulty = 3;
          # TODO make declarative whitelist
          white-list = true;
          motd = "Silmar's GREG TECH Adventure";
          op-permission-level = 4;
          level-name = "world";
          allow-flight = true;
          prevent-proxy-connections = false;
          max-world-size = 29999984;
          network-compression-threshold = 256;
          spawn-npcs = true;
          spawn-animals = true;
          hardcore = false;
          snooper-enabled = true;
          online-mode = true;
          pvp = true;
          enable-command-block = false;
          gamemode = 0;
          player-idle-timeout = 0;
          max-players = 20;
          spawn-monsters = true;
          view-distance = 10;
          generate-structures = true;
          level-type = "lostcities";
          /*
           max-players = 5;
           white-list = true;
           enable-rcon = true;
           "rcon.password" = "hunter2";
          */
        };
      };
    };
  };
}
