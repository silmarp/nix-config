# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ config, pkgs, lib, ... }:

{
  imports =
    [ # Include the results of the hardware scan.
      ./hardware-configuration.nix
    ];

  # Use the systemd-boot EFI boot loader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  # Allow use of unfree software
  nixpkgs.config.allowUnfree = true;
  hardware.enableAllFirmware = true;

  # networking.hostName = "nixos"; # Define your hostname.
  networking.hostName = "behemoth";
  # Pick only one of the below networking options.
  networking.wireless = {
    enable = true;  # Enables wireless support via wpa_supplicant.
    userControlled.enable = true;
  };
  # networking.networkmanager.enable = true;  # Easiest to use and most distros use this by default.

  # Set your time zone.
  time.timeZone = "America/Sao_Paulo";

  # Configure network proxy if necessary
  # networking.proxy.default = "http://user:password@proxy:port/";
  # networking.proxy.noProxy = "127.0.0.1,localhost,internal.domain";

  # Select internationalisation properties.
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
    lidSwitch = "lock";
    lidSwitchExternalPower = "lock";
  };
  
  # Enable Wayland windowing system
  security.polkit.enable = true; #sway privileges suport
  hardware = {
    opengl = {
      enable = true;
      extraPackages = with pkgs; [ amdvlk ];
      driSupport = true;
      driSupport32Bit = true;
    };
  };

  # Enable the X11 windowing system.
  # services.xserver.enable = true;

  # Configure keymap in X11
  # services.xserver.layout = "us";
  # services.xserver.xkbOptions = {
  #   "eurosign:e";
  #   "caps:escape" # map caps to escape.
  # };

  # Enable CUPS to print documents.
  # services.printing.enable = true;

  # Enable sound.
  # sound = {
  #     enable = true;
  #     mediaKeys.enable = true;
  # };
  security.rtkit.enable = true;
  services.pipewire = {
      enable = true;
      alsa.enable = true;
      alsa.support32Bit = true;
      pulse.enable = true;
      wireplumber.enable = true;
  };

  # TODO Move Pam to its own config
  security.pam.services = { swaylock = { }; };
  # Enable touchpad support (enabled default in most desktopManager).
  # services.xserver.libinput.enable = true;

  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users.silmar = {
    isNormalUser = true;
    extraGroups = [
      "wheel" # Enable ‘sudo’ for the user.
      "video" # Enable changing video settings
      "input"
      "docker"
      "libvirtd"
    ]; 
  };

  nix = {
      settings = {
      	  # Enable flakes and 'nix' command
          experimental-features = "nix-command flakes";
	  # Optimazes nix store
	  auto-optimise-store = true;
      };
      # Garbage collection config
      gc = {
          automatic = true;
	  dates = "weekly";
	  options = "--delete-older-than 7d";
      };
  };

  services.dbus.enable = true;
  services.flatpak.enable = true;
  xdg.portal = {
    enable = true;
    extraPortals = with pkgs; [
      xdg-desktop-portal-gtk
      xdg-desktop-portal-wlr
    ];
  };
  # List packages installed in system profile. To search, run:
  # $ nix search wget
  environment.systemPackages = with pkgs; [
    glib
    wget
    luakit
    alsa-tools
    alsa-utils
    alsa-lib
    virt-manager
  ];

  fonts.fonts = with pkgs; [
    nerdfonts
    font-awesome
  ];

  programs.zsh = {
      enable = true;
      shellInit = "
          bindkey -v
	  HISTSIZE=500
	  \. \"$HOME/.nix-profile/etc/profile.d/hm-session-vars.sh\"
      ";
      shellAliases = {
          ls="ls --color";
	  grep="grep --color";
      };

  };
  programs.starship = {
      enable = true;
      settings = {
          format = "$all";
	  add_newline = false;
      };
  };
  users.defaultUserShell = pkgs.zsh;

  # Enable virtualisation
  virtualisation.libvirtd.enable = true;
  programs.dconf.enable = true;

  # Some programs need SUID wrappers, can be configured further or are
  # started in user sessions.
  # programs.mtr.enable = true;
  # programs.gnupg.agent = {
  #   enable = true;
  #   enableSSHSupport = true;
  # };

  # List services that you want to enable:

  # Enable the OpenSSH daemon.
  services.openssh.enable = true;

  # Enable docker
  virtualisation.docker.enable = true;

  # Open ports in the firewall.
  # networking.firewall.allowedTCPPorts = [ ... ];
  # networking.firewall.allowedUDPPorts = [ ... ];
  # Or disable the firewall altogether.
  # networking.firewall.enable = false;

  # Copy the NixOS configuration file and link it from the resulting system
  # (/run/current-system/configuration.nix). This is useful in case you
  # accidentally delete configuration.nix.
  # system.copySystemConfiguration = true;

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "22.05"; # Did you read the comment?

}

