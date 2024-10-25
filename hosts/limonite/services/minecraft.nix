{ pkgs, inputs, ... }:

let
  java8 = pkgs.jre8;

  mine-server = pkgs.minecraft-server.overrideAttrs (finalAttrs: previousAttrs: {
    version = "1.21.1";
    });
in
{
  #imports = [ inputs.modded-minecraft.module ];

  services.minecraft-server = {
    enable = true;
    package = mine-server;
    dataDir = "/var/lib/mc-vanilla";
    declarative = true;
    eula = true;
    #jvmOpts = "-Xmx2048M -Xms2048M";
    openFirewall = true;
    serverProperties = {
      server-port = 43000;
      difficulty = 2;
      gamemode = 0;
      max-players = 3;
      motd = "Silmar's vanilla server";
      white-list = true;
      #enable-rcon = true;
      #"rcon.password" = "hunter2";
    };
    whitelist = {
      switchsilver = "da246bf3-b644-42a2-bdd3-31e8a7f52bbc";
      Ovelha666 = "55541d08-8c32-4fac-8444-1c966de78531";
    };
  };

  networking.firewall.allowedTCPPorts = [ 43000 ];

/*
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
           #max-players = 5;
           #white-list = true;
           #enable-rcon = true;
           #"rcon.password" = "hunter2";
        };
      };
    };
  };
  */
}
