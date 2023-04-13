{ config, pkgs, ... }:

{
  # Home Manager needs a bit of information about you and the
  # paths it should manage.
  home.username = "silmar";
  home.homeDirectory = "/home/silmar";

  imports = [ 
    ./taskwarrior
    ./neovim
    ./sway
    ./zsh
  ];

  nixpkgs.config.allowUnfree = true;
  home.packages = with pkgs; [
      # TODO move wpa to its own module
      zsnes # TODO remove or move to games section
      htop
      firefox-wayland
      librewolf-wayland
      qutebrowser
      discord
      wl-clipboard
      bitwarden-cli
      rnix-lsp
      nodePackages.bash-language-server
      polymc # change to another (prism)
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
      haskellPackages.Monadoro
      zellij
      zathura
      spotifyd
      spotify-tui
      kabmat
      taskwarrior-tui
      steam
      lutris
      wine
      osu-lazer
      bitwarden
      emacs
      ferdium
      (tor-browser-bundle-bin.override {
        useHardenedMalloc = false;
       })
      gnome.pomodoro
      element-desktop
  ];

  programs.git = {
    enable = true;
    diff-so-fancy.enable = true;
  };

  
  # This value determines the Home Manager release that your
  # configuration is compatible with. This helps avoid breakage
  # when a new Home Manager release introduces backwards
  # incompatible changes.
  #
  # You can update Home Manager without changing this value. See
  # the Home Manager release notes for a list of state version
  # changes in each release.
  home.stateVersion = "22.05";

  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;

}
