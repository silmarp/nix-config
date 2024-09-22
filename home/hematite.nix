{ pkgs, ... }:

{
  imports = [
    ./global

    ./features/neovim
  ];

  home.packages = with pkgs; [
    lunarvim
    ansible
  ];
}
