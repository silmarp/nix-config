{...}:

{
  imports = [
    ../../common/optional/nginx.nix

    ./radicale.nix
    ./git-server.nix
    ./nextcloud.nix
  ];
}
