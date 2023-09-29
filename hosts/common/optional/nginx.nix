{ ... }:

{
  services.nginx = {
    enable = true;
  };

  # Letsencrypt cert provisioning
  security.acme = {
    defaults.email = "silmarjr2@gmail.com";
    acceptTerms = true;
  };

  networking.firewall.allowedTCPPorts = [ 80 443 ];
}
