{ pkgs, inputs,  ... }:

{
  imports = [
    ./global

    ./features/neovim

    ./features/desktop/hyprland
    
    ./features/cli/nushell.nix
    ./features/cli/starship.nix
    ./features/cli/direnv.nix
    ./features/cli/git.nix

    ./features/productivity
  ];

wallpaper = builtins.fetchurl {
  url = "https://i.stack.imgur.com/cmoDG.jpg";
  sha256 = "0f701igjzh8593if7z0hzx1aj7cy0c9i0vscs1pdcp16ibp2vy14";
};

  home.packages = with pkgs; [
    inputs.nixgl.packages.x86_64-linux.nixGLIntel
    lunarvim
    ansible
    commitizen
  ];
}
