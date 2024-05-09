{config, ...}:

{
  sops.secrets.vpn = {
    sopsFile = ../secrets.yaml;
    neededForUsers = true;
  };

  networking.openconnect.interfaces = {
    eduroam = {
      gateway = "vpn.semfio.usp.br";
      protocol = "anyconnect";
      autoStart = false;
      user = "12623950";
      passwordFile = config.sops.secrets.vpn.path;
    };
  };
}
