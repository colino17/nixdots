{
  lib,
  fetchFromGitHub,
  rustPlatform,
  libcosmicAppHook,
  pkg-config,
  fontconfig,
  freetype,
  libinput,
  udev,
  brightnessctl,
  power-profiles-daemon,
  asusctl,
}:

let
  appId = "cosmic-applet-superpower";
in
rustPlatform.buildRustPackage {
  pname = "cosmic-applet-superpower";
  version = "0.1.0";

  src = fetchFromGitHub {
    owner = "colino17";
    repo = "cosmic-applet-superpower";
    rev = "4d72d1d6fa54f3d0736ae50c7fee8e211295889a";
    hash = "sha256-JsIP1y1OLxBGpdHYJ3hzA7ULzp+iOZrUrc1PN2GLaQ0=";
  };

  cargoHash = "sha256-KwcA0C7tVWBSlV7jwr4dHpjyhLO7CPn3/i1dJwuBIrQ=";

  nativeBuildInputs = [
    libcosmicAppHook
    pkg-config
  ];

  buildInputs = [
    fontconfig
    freetype
    libinput
    udev
  ];

  doCheck = false;

  postInstall = ''
    install -Dm644 data/${appId}.desktop \
      $out/share/applications/${appId}.desktop

    substituteInPlace $out/share/applications/${appId}.desktop \
      --replace-fail "Exec=cosmic-applet-superpower" "Exec=$out/bin/cosmic-applet-superpower"
  '';

  preFixup = ''
    libcosmicAppWrapperArgs+=(
      --suffix PATH : ${
        lib.makeBinPath [
          brightnessctl
          power-profiles-daemon
          asusctl
        ]
      }
    )
  '';

  meta = {
    description = "An alternative battery applet for the COSMIC desktop designed to be used with an ASUS laptop on NixOS";
    mainProgram = "cosmic-applet-superpower";
    platforms = lib.platforms.linux;
  };
}
