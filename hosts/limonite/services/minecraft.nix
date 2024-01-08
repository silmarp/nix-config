{ pkgs, ... }:

let
  nomifactory = (pkgs.minecraft-server.overrideAttrs (old: rec {
    name = "minecraft-server-1.12.2";
    version = "1.12.2";
    src = builtins.fetchurl {
      url = "https://www.curseforge.com/api/v1/mods/594351/files/4941627/download";
      sha256 = "sha256:01xlrvadi246sg5gxrbpvz76rfyvk7cc8pa5y58h0mm8siplyql8";
    };
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
       gamemode = 1;
       motd = "Silmar's GREG TECH Adventure";
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
