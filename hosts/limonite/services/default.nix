{ ... }:

{
  imports = [
    ../../common/optional/nginx.nix

    ./website.nix
    ./minecraft.nix
  ];
}
