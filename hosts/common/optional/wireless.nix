{ config, ... }:

{
  sops.secrets.wireless = {
    sopsFile = ../secrets.yaml;
    neededForUsers = true;
  };


  networking.wireless = {
    enable = true;  # Enables wireless support via wpa_supplicant.
    fallbackToWPA2 = false;
    secretsFile = config.sops.secrets.wireless.path;
    networks = { 
      "NET_5G2D9052" = {
        psk = "@HOME_NETWORK_PASS@";
      };
      "eduroam" = {
        authProtocols = ["WPA-EAP"];
        auth = ''
          pairwise=CCMP
          group=CCMP TKIP
          eap=TTLS
          domain_suffix_match="semfio.usp.br"
          identity="12623950@usp.br"
          password="@EDUROAM@"
          phase2="auth=MSCHAPV2"
        '';
      };
    };

    # imperative networks
    allowAuxiliaryImperativeNetworks = true;
    userControlled.enable = true;
    extraConfig = ''
      update_config=1
    '';
  };

  #solves cannot open file error
  systemd.services.wpa_supplicant.preStart = "touch /etc/wpa_supplicant.conf";
}
