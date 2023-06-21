{ config, pkgs, ... }:

{
  # Home Manager needs a bit of information about you and the
  # paths it should manage.
  imports = [ 
    ./global

    ./features/taskwarrior
    ./features/neovim
    ./features/sway
    ./features/zsh
    ./features/alacritty
  ];

  home.packages = with pkgs; [
      # TODO move wpa to its own module
      zsnes # TODO remove or move to games section
      htop
      firefox-wayland
      qutebrowser
      discord
      wl-clipboard
      rnix-lsp
      nodePackages.bash-language-server
      prismlauncher
      gimp
      helix
      calcurse
      neomutt # email client
      feh # image viewer
      graphviz  # graph tool
      nyxt # keyboard browser
      rssguard # RSS feed reader
      grim
      slurp
      zellij
      zathura
      spotifyd
      spotify-tui
      kabmat
      steam
      lutris
      wine
      osu-lazer
      bitwarden
      ferdium
      (tor-browser-bundle-bin.override {
        useHardenedMalloc = false;
       })
      element-desktop
      rage # encryption tool
      zk # Note taking/ knowledge management app
      libreoffice # Office suit
  ];
}
