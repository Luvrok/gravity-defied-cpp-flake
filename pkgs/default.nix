{ lib
, stdenv
, makeDesktopItem
, cmake
, pkg-config
, SDL2
, SDL2_image
, SDL2_ttf
, src
}:

stdenv.mkDerivation rec {
  pname = "gravity-defied-cpp";
  version = "0.2";

  inherit src;

  desktop = makeDesktopItem {
    name = pname;
    desktopName = "Gravity Defied CPP";
    exec = pname;
    icon = pname;
    comment = "Rewrite Gravity Defied mobile game from Java to C++ and SDL";
    type = "Application";
    categories = [ "Game" ];
    genericName = "Gravity Defied";
  };

  nativeBuildInputs = [ cmake pkg-config ];
  buildInputs = [ SDL2 SDL2_image SDL2_ttf ];

  postPatch = ''
    substituteInPlace CMakeLists.txt \
      --replace "unset(ENV{PKG_CONFIG_PATH})" ""
  '';

  cmakeFlags = [
    "-DCMAKE_BUILD_TYPE=Release"
  ];

  installPhase = ''
    runHook preInstall

    install -Dm755 GravityDefied $out/bin/${pname}
    install -Dm644 ${desktop}/share/applications/${pname}.desktop \
      $out/share/applications/${pname}.desktop

    runHook postInstall
  '';

  meta = with lib; {
    description = "Rewrite Gravity Defied mobile game from Java to C++ and SDL";
    homepage = "https://github.com/rgimad/gravity_defied_cpp";
    license = licenses.gpl2Only;
    platforms = platforms.linux;
    mainProgram = pname;
  };
}
