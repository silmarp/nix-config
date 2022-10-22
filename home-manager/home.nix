{ config, pkgs, ... }:

{
  # Home Manager needs a bit of information about you and the
  # paths it should manage.
  home.username = "silmar";
  home.homeDirectory = "/home/silmar";

  imports = [ ./taskwarrior.nix ];

  nixpkgs.config.allowUnfree = true;
  home.packages = with pkgs; [
      htop
      firefox
      librewolf-wayland
      qutebrowser
      discord
      wl-clipboard
      bitwarden-cli
      rnix-lsp
      polymc
      gimp
      helix
      calcurse
      neomutt # email client
      feh # image viewer
      graphviz  # graph tool
      grim
      slurp
      haskellPackages.Monadoro
      tmate
      zellij
      zathura
      spotifyd
      spotify-tui
      taskell
      unityhub
      (callPackage ./kabmat{})
      taskwarrior-tui
      steam
      lutris
      wine
      osu-lazer
      ripes
  ];

  home.sessionVariables = {
      BW_SESSION = "zHhTz2HsbSh2QpTkkDJuqtc1WQte68fuq0WyScijLIkD5y5kjnBGiWeFL77LOn6v8fI7jRL9nsq+ohKkRM9i1Q==";
  };

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
