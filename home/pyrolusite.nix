{ config, pkgs, ... }:

{
  # Home Manager needs a bit of information about you and the
  # paths it should manage.
  imports = [ 
    ./global

    ./features/neovim

    ./features/desktop/sway

    ./features/desktop/hyprland

    ./features/games

    ./features/productivity

    ./features/cli
  ];

wallpaper = builtins.fetchurl {
  url = "https://i.stack.imgur.com/cmoDG.jpg";
  sha256 = "0f701igjzh8593if7z0hzx1aj7cy0c9i0vscs1pdcp16ibp2vy14";
};

  home.packages = with pkgs; [
      discord
      
      nodePackages.bash-language-server

      feh # image viewer TODO make separate config
      rssguard # RSS feed reader
      zathura # TODO make config
      bitwarden
      tor-browser-bundle-bin
      element-desktop
      libreoffice # Office suit

      spotify
      dbeaver
  ];
}
