{
  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/master";
    flake-utils.url = "github:numtide/flake-utils";
    # TODO Use a declarative way in the future
  };

  outputs = {self, nixpkgs, flake-utils }@inp:
  flake-utils.lib.eachDefaultSystem (system:
      let
        pkgs = import nixpkgs { inherit system; };
      in
      {
        devShell = pkgs.mkShell {
          nativeBuildInputs = with pkgs; [
            python310
            python310Packages.pip
            python310Packages.virtualenv

            nodePackages.pyright
          ];
        };
      });
}
