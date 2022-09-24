{ lib, stdenv, fetchFromGitHub, ncurses, cmake }:

with lib;

in stdenv.mkDerivation rec {
  pname = "kabmat";
  version = "v2.7.0";
  src = fetchFromGitHub {
    owner = "PlankCipher";
    repo = pname;
    rev = version;
    sha256 = "sha256-EnkW14L/y20IrSDxO7kbMP33/jEMKCLR6+m3V92BfMQ=";
  };

  makeFlags = [
    "INSTALL_DIR=$(out)"
    "PREFIX=$(out)"
    "DATA_DIR=./"
  ];

  buildInputs = [ ncurses ];

  installPhase = ''
    mkdir -p $out/bin
    cp ./kabmat $out/bin/kabmat
	mkdir -p $out/share/man/man1
	cp ./doc/kabmat.1 $out/share/man/man1/
  '';
}
