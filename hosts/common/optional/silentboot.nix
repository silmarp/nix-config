{ pkgs, ... }:

{
  # Skip bootloader
  boot.loader.timeout = 0;

  # Displays image on boot
  boot.plymouth = {
    enable = true;
    theme = "spinfinity";
    themePackages = [pkgs.plymouth-hexagon-2];
  };

  boot = {
    kernelParams = [
      "quiet"
      "loglevel=3"
      "systemd.show_status=auto"
      "udev.log_level=3"
      "rd.udev.log_level=3"
      "vt.global_cursor_default=0"
    ];
    consoleLogLevel = 0;
    initrd.verbose = false;
  };
}
