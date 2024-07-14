{
  stdenv,
  fetchzip
}:

stdenv.mkDerivation {
  pname = "plymouth-hexagon-2";
  version = "1.0";

  src = fetchzip {
    url = "https://github.com/adi1090x/plymouth-themes/releases/download/v1.0/hexagon_2.tar.gz";
    hash = "sha256-ldYg0ZnqocfZyZaFE/BRnER2u8ESFW35iM58t/ARxZE=";
  };

  dontBuild = true;
   installPhase = ''
    runHook preInstall
    mkdir -p $out/share/plymouth/themes
    cp -rT . $out/share/plymouth/themes/hexagon_2
    runHook postInstall
  ''; 
}

