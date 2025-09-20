{ config, pkgs, ... }:

{
  imports = [
  ];

  programs.neovim = {
    enable = true;
    viAlias = true;
    defaultEditor = true;
    extraLuaConfig = /* lua */ ''
    '';
  };
}
