{ pkgs, inputs,  ... }:

{
  imports = [
    ./global

    ./features/neovim
    
    ./features/cli/nushell.nix
    ./features/cli/starship.nix
    ./features/cli/direnv.nix
  ];

  home.packages = with pkgs; [
    inputs.nixgl.packages.x86_64-linux.nixGLIntel
    lunarvim
    ansible
    commitizen
  ];
}
