{ ... }:
{
  hardware.bluetooth = {
    enable = true;
    # Do not start on boot
    powerOnBoot = false;
    settings = {
      General = {
        Experimental = true;
      };
    };
  };
  services.blueman.enable = true;
}
