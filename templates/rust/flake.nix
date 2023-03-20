{
  inputs = {
    naersk.url = "github:nix-community/naersk/master";
    nixpkgs.url = "github:NixOS/nixpkgs/nixpkgs-unstable";
    flake-utils.url = "github:numtide/flake-utils";
  };

  outputs = { self, nixpkgs, flake-utils, naersk }:
    flake-utils.lib.eachDefaultSystem (system:
      let
        pkgs = import nixpkgs { inherit system; };
        naersk-lib = pkgs.callPackage naersk { };
      in
      {
        # for 'nix build' & 'nix run'
        packages =  {
        # for selecting package 'nix build/run .#<package>'
          default = naersk-lib.buildPackage {
          # TODO Add your own naersk parameters 
            src = ./.;
          };
        };
        
        # for 'nix develop'
        devShells = {
          default = with pkgs; mkShell {
            buildInputs = [ cargo rust-analyzer ];
          };
        };
      });
}
