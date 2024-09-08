{pkgs, config, ...}:

let
  hostName = "nextcloud.silmarp.dev";
in
{
  services = {
    nextcloud = {
      enable = true;
      inherit hostName;
      package = pkgs.nextcloud29;
      https = true;

      home = "/media/nextcloud";
      config.adminpassFile = config.sops.secrets.nextcloud-pass.path;

      extraApps = {
        inherit (config.services.nextcloud.package.packages.apps) deck;
      };
      extraAppsEnable = true;
    };

    nginx.virtualHosts.${hostName} = {
      forceSSL = true;
      enableACME = true;
    };
  };
  security.acme.certs.${hostName} = {
      dnsProvider = "porkbun";
      webroot = null;
      credentialFiles = {
        "PORKBUN_API_KEY_FILE" = config.sops.secrets.api_key.path;
        "PORKBUN_SECRET_API_KEY_FILE" = config.sops.secrets.secret_key.path;
      };
    };

  sops.secrets = {
   api_key.sopsFile = ../secrets.yaml;
   secret_key.sopsFile = ../secrets.yaml;
    nextcloud-pass = {
      owner = "nextcloud";
      group = "nextcloud";
      sopsFile = ../secrets.yaml;
    };
  };
}
