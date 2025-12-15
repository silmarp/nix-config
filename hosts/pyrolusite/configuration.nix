{ pkgs, ... }:

{
  imports =
    [
      ./hardware-configuration.nix

      ../common/global
      ../common/users/silmar

      ../common/optional/greetd.nix
      ../common/optional/wireless.nix
      ../common/optional/openconnect.nix
      ../common/optional/silentboot.nix
      ../common/optional/bluetooth.nix
      ../common/optional/devices.nix
    ];

  # Use the systemd-boot EFI boot loader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  # Allows cross compilation to arm hosts
  boot.binfmt.emulatedSystems = [ "aarch64-linux" ];

  hardware.enableAllFirmware = true;

  networking.hostName = "pyrolusite";

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

