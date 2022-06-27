{ lib, stdenv, fetchFromGitHub }:

stdenv.mkDerivation rec {
  pname = "gnome-shell-extension-paperwm";
  version = "main";

  src = fetchFromGitHub {
    owner = "maxgallup";
    repo = "tailscale-status";
    rev = version;
    sha256 = "1jq15qrq3khqpjsjbcc17amdr1k53jkvambdacdf56xbqkycvlgs";
  };

  passthru.extensionUuid = "tailscale-status@maxgallup.github.com";

  dontBuild = true;

  installPhase = ''
    runHook preInstall
    mkdir -p "$out/share/gnome-shell/extensions/tailscale-status@maxgallup.github.com"
    cp -r . "$out/share/gnome-shell/extensions/tailscale-status@maxgallup.github.com"
    runHook postInstall
  '';

  meta = with lib; {
    description = "Easily view the status of your tailscale mesh network and toggle the status of your own machine";
    homepage = "https://github.com/maxgallup/tailscale-status";
    license = licenses.gpl2;
    maintainers = with maintainers; [ maxgallup ];
  };
}
