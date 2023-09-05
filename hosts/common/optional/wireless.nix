{ ... }:

{
  networking.wireless = {
    enable = true;  # Enables wireless support via wpa_supplicant.
    fallbackToWPA2 = false;
    # TODO add declarative networks with SOPs 
    networks = { 
      # TODO remove dummy network
      "DUMMY" = { # Dummy network to prevent wpa_supplicant failing to restart
        psk = "DUMMYDUMMY";
      };
    };

    # imperative networks
    allowAuxiliaryImperativeNetworks = true;
    userControlled.enable = true;
    extraConfig = ''
      update_config=1
    '';
  };
}
