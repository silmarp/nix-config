{ pkgs,  ... }:

{
  imports = [
    ./global

    ./features/neovim

    ./features/helix

    ./features/desktop/hyprland
    
    ./features/cli

    ./features/productivity
  ];

  wallpaper = builtins.fetchurl {
    url = "https://i.stack.imgur.com/cmoDG.jpg";
    sha256 = "0f701igjzh8593if7z0hzx1aj7cy0c9i0vscs1pdcp16ibp2vy14";
  };

  home.packages = with pkgs; [
    commitizen
    discord-canary
    spotify
  ];
}
