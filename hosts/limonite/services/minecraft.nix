{ pkgs, inputs, ... }:

let
  modpack = pkgs.fetchPackwizModpack {
    url = "https://github.com/silmarp/modpack/raw/1.0.0/pack.toml";
    packHash = "sha256-aPo4bh3S7rbbcerZicMrqCMXoR1Qlf0aqtmshtzqgC8=";
  };
in
{
  imports = [ inputs.nix-minecraft.nixosModules.minecraft-servers ];
  nixpkgs.overlays = [ inputs.nix-minecraft.overlay ];

  services.minecraft-servers = {
    dataDir = "/var/lib/minecraft";
    eula = true;
    openFirewall = true;
    managementSystem.systemd-socket.enable = true;
    servers = {
      silmay = {
        enable = true;
        package = pkgs.fabricServers.fabric-1_21_8.override { loaderVersion = "0.17.2"; };
        symlinks = {
          "mods" = "${modpack}/mods";
        };

        jvmOpts = "-Xms4092M -Xmx4092M";
        serverProperties = {
          server-port = 43000;
          difficulty = 3;
          gamemode = 0;
          max-players = 10;
          motd = "Silmar's modded server";
          white-list = true;
          allow-cheats = true;
          op-permission-level = 2;
          #enable-rcon = true;
          #"rcon.password" = "hunter2";
        };
        whitelist = {
          switchsilver = "da246bf3-b644-42a2-bdd3-31e8a7f52bbc";
          Ovelha666 = "55541d08-8c32-4fac-8444-1c966de78531";
        };
      };
    };
  };
/*
  services.minecraft-server = {
    enable = true;
    package = mine-server;
    dataDir = "/var/lib/mc-vanilla";
    declarative = true;
    eula = true;
    jvmOpts = "-Xms4092M -Xmx4092M";
    openFirewall = true;
    serverProperties = {
      server-port = 43000;
      difficulty = 3;
      gamemode = 0;
      max-players = 10;
      motd = "Silmar's vanilla server";
      white-list = true;
      allow-cheats = true;
      op-permission-level = 2;
      #enable-rcon = true;
      #"rcon.password" = "hunter2";
    };
    whitelist = {
      switchsilver = "da246bf3-b644-42a2-bdd3-31e8a7f52bbc";
      Ovelha666 = "55541d08-8c32-4fac-8444-1c966de78531";
      ZAP = "1ff35137-8195-4f36-b398-08a03e6e6b11";
      Gnoto = "3dfecd45-7420-41a3-817a-5ff85180cef8";
      Gab = "e8c2d509-dcbd-4077-b74a-fcdab32c7a86";
    };
  };

*/
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
