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
    "rutile.tail4dadf.ts.net" = {
      forceSSL = true;
      enableACME = true;
      locations."/".proxyPass = "http://127.0.0.1:5232";
    };
  };
}
