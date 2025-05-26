{ config, ... }:

{
  sops.secrets.wireless = {
    sopsFile = ../secrets.yaml;
    neededForUsers = true;
    group = "network";
  };


  networking.wireless = {
    enable = true;  # Enables wireless support via wpa_supplicant.
    fallbackToWPA2 = false;
    secretsFile = config.sops.secrets.wireless.path;
    networks = { 
      "NET_5G2D9052" = {
        pskRaw = "ext:home_psk";
      };
      "NET_2G2D9052" = {
        pskRaw = "ext:home_psk";
      };
      "eduroam" = {
        authProtocols = ["WPA-EAP"];
        auth = ''
          pairwise=CCMP
          group=CCMP TKIP
          eap=TTLS
          domain_suffix_match="semfio.usp.br"
          ca_cert="${./eduroam-cert.pem}"
          identity="12623950@usp.br"
          password=ext:eduroam_psk
          phase2="auth=MSCHAPV2"
        '';
      };
    };

    # imperative networks
    allowAuxiliaryImperativeNetworks = true;
    userControlled = {
      enable = true;
      group = "network";
    };

    extraConfig = ''
      update_config=1
    '';
  };

  # ensure group exists
  users.groups.network = {};

  #solves cannot open file error
  systemd.services.wpa_supplicant.preStart = "touch /etc/wpa_supplicant.conf";
}
