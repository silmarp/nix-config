{ pkgs, inputs, ... }:

let
  website = inputs.website.packages.${pkgs.system}.default;

in

{
services.nginx.virtualHosts = {
    "silmarp.dev" = {
      default = true;
      forceSSL = true;
      enableACME = true;
      locations = {
        "/" = {
          root = "${website}/";
          # TODO add headers
        };
      };
    };
  };
}
