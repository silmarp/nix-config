{
  appimageTools,
  fetchurl,
  dieHook,
  makeWrapper,
  glibc,
}:

let
  pname = "salinha";
  version = "1.0.0";

  src = fetchurl {
    url = "https://salinha.live/baixar/linux";
    hash = "sha256-YpOv+JjErvOo7Jw5chQ7OSXD6kQ6SLsu9eot6cUGBM4=";
    name = "${pname}-${version}.AppImage";
  };

  appimageContents = appimageTools.extractType2 {
    inherit pname version src;
  };

  libs = [
    glibc
  ];

in
appimageTools.wrapType2 rec {
  inherit pname version src;

  multiPkgs = null; # no 32bitvneeded
  extraPkgs = p: (appimageTools.defaultFhsEnvArgs.multiPkgs p) ++ libs;
  extraInstallCommands = ''
    install -m 444 -D ${appimageContents}/${pname}.desktop -t $out/share/applications
    cp -r ${appimageContents}/usr/share/icons $out/share

    # cringe hack to get wrapProgram working in extraInstallCommands
    source "${dieHook}/nix-support/setup-hook"
    source "${makeWrapper}/nix-support/setup-hook"

    mv $out/bin/${pname} $out/bin/${pname}-${version}
    makeWrapper $out/bin/${pname}-${version} $out/bin/${pname} \
      --unset APPIMAGE \
      --unset APPDIR
  '';


  meta = {
    description = "Salinha para Linux: chamadas de voz, transmissão de tela e grupos com os amigos.";
    homepage = "https://salinha.live";
    downloadPage = "https://salinha.live/baixar/linux";
    # license = lib.licenses.asl20;
    # sourceProvenance = with lib.sourceTypes; [ binaryNativeCode ];
    # maintainers = with lib.maintainers; [ silmar ];
    # platforms = [ "x86_64-linux" ];
  };
}


