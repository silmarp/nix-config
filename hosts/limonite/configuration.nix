# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running `nixos-help`).

{ config, pkgs, ... }:

{
  imports =
    [ # Include the results of the hardware scan.
      ./hardware-configuration.nix

      ../common/global
      ../common/users/silmar
    ];

  # Use the systemd-boot EFI boot loader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  networking.hostName = "limonite"; # Define your hostname.

  # Temporary, for initial setup
  users = { 
    mutableUsers = false;
    users.root = {
      password = "root";
      openssh.authorizedKeys.keys = [ (builtins.readFile ../../home/ssh.pub) ];
    };
  };

  system.stateVersion = "23.05"; # Did you read the comment?
}

