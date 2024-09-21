{ pkgs,  ... }:

{
  imports = [
    ./browser/firefox.nix
    ./browser/qutebrowser.nix

    ./gtk.nix
    ./alacritty.nix
    ./kitty.nix
    ./mpv.nix
    ./zathura.nix
  ];

  xdg.portal.enable = true;

  # Add fonts TODO move to own config
  fonts.fontconfig.enable = true;
  home.packages = with pkgs; [ 
    maple-mono 
    noto-fonts-color-emoji 
    nerdfonts

    vesktop
  ];
}
