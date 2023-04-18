{
  description = "Markdown to pdf document";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixpkgs-unstable";
    flake-utils.url = "github:numtide/flake-utils";
  };

  outputs = { self, nixpkgs, flake-utils }:
    flake-utils.lib.eachDefaultSystem (system:
      let 
        pkgs = nixpkgs.legacyPackages.${system}; 
      in
      {
        packages = rec {
          document = pkgs.stdenv.mkDerivation rec{
            name = "document";
            src = ./src/. ;
            nativeBuildInputs = with pkgs; [
              pandoc
              texlive.combined.scheme-small
            ];
            buildPhase = "pandoc doc.md -o doc.pdf";
            installPhase = ''
              mkdir -p $out
              install -Dm644 *.pdf $out
            '';

          };
          default = document;
        };
        /*
        # for 'nix develop'
        devShells = {
          default = with pkgs; mkShell {
            buildInputs = [ marksman ];
          };
        };

        */
      }
    );
}
