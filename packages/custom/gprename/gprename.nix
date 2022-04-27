# https://github.com/archlinux/svntogit-community/tree/packages/gprename/trunk
{ pkgs }:

{
pkgs.stdenv.mkDerivation rec {
  pname = "gprename";
  version = "20220206";
  src = pkgs.fetchurl {
    url = https://downloads.sourceforge.net/${pname}/${version}/${pname}-${version}.tar.bz2;
    sha256 = "1f99947efa8d4864afff554b92e956837c7e76870681085663ddd1c8b7524e36";
  };
  
  buildInputs = [
    pkgs.perl534Packages.Gtk3
    pkgs.perl534Packages.libintl-perl
    pkgs.perl534Packages.LocaleGettext
    pkgs.perl534Packages.Pango
  ];
  
  patchPhase = ''
  
  '';
  
  configurePhase = ''
  
  '';
  
  buildPhase = ''
  
  '';

  installPhase = ''
  
  '';

  meta = {
    description = "GPRename is a complete batch renamer for files and directories";
    homepage = https://sourceforge.net/projects/gprename/;
  };
}
