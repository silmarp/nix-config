{ pkgs,  ... }:

{
  imports = [
    ./browser/firefox.nix
    ./browser/qutebrowser.nix

    ./gtk.nix
    ./alacritty.nix
    ./mpv.nix
  ];

  # Add fonts TODO move to own config
  fonts.fontconfig.enable = true;
  home.packages = with pkgs; [nerdfonts noto-fonts];
}
