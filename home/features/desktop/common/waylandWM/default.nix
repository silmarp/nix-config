{ ... }:
{
  imports = [
    ./mako.nix
    ./wofi.nix
    ./waybar.nix
    ./swayidle.nix
    ./swaylock.nix
  ];
  home.sessionVariables = {
    MOZ_ENABLE_WAYLAND = 1;
  };
}
