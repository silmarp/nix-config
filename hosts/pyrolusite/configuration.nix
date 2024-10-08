{ pkgs, ... }:

{
  imports =
    [
      ./hardware-configuration.nix

      ../common/global

      ../common/optional/greetd.nix
      ../common/optional/wireless.nix

      ../common/users/silmar
      ../common/optional/openconnect.nix
    ];

  # Loader can be accessed by pressing space
  boot.loader.timeout = 0;

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

  # Use the systemd-boot EFI boot loader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  # Allows cross compilation to arm hosts
  boot.binfmt.emulatedSystems = [ "aarch64-linux" ];

  hardware.enableAllFirmware = true;

  networking.hostName = "pyrolusite";

  hardware.bluetooth = {
    enable = true;
    powerOnBoot = false;
    settings = {
      General = {
        Experimental = true;
      };
    };
  };
  services.blueman.enable = true;

  # TODO move to locale global config
  time.timeZone = "America/Sao_Paulo";

  i18n.defaultLocale = "en_US.UTF-8";
  i18n.extraLocaleSettings = {
      LC_TIME = "pt_BR.UTF-8";
  };
  console = {
    font = "Lat2-Terminus16";
    keyMap = "br-abnt2";
  };

  # Lid settings
  services.logind ={
    lidSwitch = "suspend";
    lidSwitchExternalPower = "suspend";
  };

  
  # Enable Wayland windowing system
  security.polkit.enable = true; #sway privileges suport
  hardware = {
    graphics = {
      enable = true;
      extraPackages = with pkgs; [ amdvlk ];
      enable32Bit = true;
    };
  };

  security.rtkit.enable = true;
  services.pipewire = {
      enable = true;
      alsa.enable = true;
      alsa.support32Bit = true;
      pulse.enable = true;
      jack.enable = true;
      wireplumber.enable = true;
  };
  
  security.pam.services = { swaylock = { }; };

  services.dbus.enable = true;

  environment.pathsToLink = [ "/share/zsh" ];

  # Enable virtualisation
  virtualisation.libvirtd.enable = true;
  programs.dconf.enable = true;

  # Enable docker
  virtualisation.docker.enable = true;

  # Before changing this value read the documentation for this option
  system.stateVersion = "22.05";

}

