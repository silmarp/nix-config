{...}:

{
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
      htpasswd_filename = "/etc/radicale/users";
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
        "PORKBUN_API_KEY_FILE" = /tmp/secrets/api_key;
        "PORKBUN_SECRET_API_KEY_FILE" = /tmp/secrets/secret_key;
      };
    };
  };
}
