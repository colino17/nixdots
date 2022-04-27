{ pkgs, Gtk3, libintl-perl, perl534Packages }:

{
pkgs.stdenv.mkDerivation rec {
  pname = "gprename";
  version = "20220206";
  src = pkgs.fetchurl {
    url = https://downloads.sourceforge.net/${pname}/${version}/${pname}-${version}.tar.bz2;
    sha256 = "1f99947efa8d4864afff554b92e956837c7e76870681085663ddd1c8b7524e36";
  };
  
  buildInputs = with perl534Packages [
    Gtk3
    libintl-perl
    Pango
  ];
}
