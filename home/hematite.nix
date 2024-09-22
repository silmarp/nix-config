{ pkgs, inputs,  ... }:

{
  imports = [
    ./global

    ./features/neovim
  ];

  home.packages = with pkgs; [
    inputs.nixgl.packages.x86_64-linux.nixGLIntel
    lunarvim
    ansible
  ];
}
