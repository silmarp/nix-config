{ pkgs, ... }:

let
  nomifactory = (pkgs.minecraft-server.overrideAttrs (old: {
    name = "minecraft-server-1.12.2";
    version = "1.12.2";
    src = builtins.fetchurl {
      url = "https://www.curseforge.com/api/v1/mods/594351/files/4941627/download";
      sha256 = "sha256:01xlrvadi246sg5gxrbpvz76rfyvk7cc8pa5y58h0mm8siplyql8";
    };
    installPhase = ''
      mkdir -p $out/bin $out/lib/minecraft
      ${pkgs.unzip}/bin/unzip $src -d $out/lib/minecraft/

      cat > $out/bin/minecraft-server << EOF
      #!/bin/sh
      exec ${pkgs.jre8}/bin/java -server \$@ -Dlog4j.configurationFile=log4j2_112-116.xml -jar $out/lib/minecraft/forge-1.12.2-14.23.5.2860.jar nogui
      EOF

      chmod +x $out/bin/minecraft-server
    '';
  }));
in
{
  services.minecraft-server = {
    enable = true;
    # Nomifactory GTCEU 1.7-alpha-2a
    package = nomifactory;
    #dataDir = "path ?";
    declarative = true;
    eula = true; # required
    jvmOpts = "-Xms10G -Xmx10G"; # TODO add launcher options (memory etc)
    serverProperties = {
      server-port = 43000;
      difficulty = 3;
      motd = "Silmar's GREG TECH Adventure";
      op-permission-level = 4;
      level-name = "world";
      allow-flight = true;
      prevent-proxy-connections = false;
      max-world-size = 29999984;
      network-compression-threshold = 256;
      max-build-height = 256;
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
    whitelist = {
      SwitchSilver = "da246bf3-b644-42a2-bdd3-31e8a7f52bbc";
      Shigueto0 = "ca31a54d-3291-4df7-9f16-3105c6077a27";
    };
  };

  networking.firewall.allowedTCPPorts = [ 43000 ];
}
