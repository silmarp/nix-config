{ pkgs, ... }:

{
  imports = [
    ./mako.nix
    ./wofi.nix
    ./waybar.nix
    ./swayidle.nix
    ./swaylock.nix
    ./rofi.nix
  ];

  home.sessionVariables = {
    MOZ_ENABLE_WAYLAND = 1;
  };

  home.packages = with pkgs; [
    wl-clipboard
  ];
}
