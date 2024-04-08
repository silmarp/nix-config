{config, ...}:

{
  sops.secrets = {
    api_key.sopsFile = ../secrets.yaml;
    secret_key.sopsFile = ../secrets.yaml;
    radicale-htpasswd = {
      sopsFile = ../secrets.yaml;
      owner = config.users.users.radicale.name;
      group = config.users.users.radicale.group;
    };
  };

  services.radicale = {
  enable = true;
  #config = '''';
  #extraArgs = [];
  #rights = {};
  settings = {
    server = {
      hosts = [ "127.0.0.1:5232" "::1:5232" ];
    };
    auth = {
      type = "htpasswd";
      htpasswd_filename = config.sops.secrets.radicale-htpasswd.path;
      htpasswd_encryption = "bcrypt";
    };
    storage = {
     filesystem_folder = "/var/lib/radicale/collections";
    };
  };
 };

  services.nginx.virtualHosts = {
    "dav.silmarp.dev" = {
      forceSSL = true;
      enableACME = true;
      locations."/".proxyPass = "http://127.0.0.1:5232";
    };
  };
  security.acme.certs = {
    "dav.silmarp.dev" = {
      dnsProvider = "porkbun";
      webroot = null;
      credentialFiles = {
        "PORKBUN_API_KEY_FILE" = config.sops.secrets.api_key.path;
        "PORKBUN_SECRET_API_KEY_FILE" = config.sops.secrets.secret_key.path;
      };
    };
  };
}
