{ pkgs, ... }:

{
  imports = [
    ./mako.nix
    ./waybar.nix
    ./swayidle.nix
    ./swaylock.nix
    ./rofi.nix
    ./wlogout.nix
  ];

  home.sessionVariables = {
    MOZ_ENABLE_WAYLAND = 1;
  };

  home.packages = with pkgs; [
    wl-clipboard
  ];

  xdg.mimeApps.enable = true;
}
