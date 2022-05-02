{ stdenv, fetchurl, pkgs, perl, gtk3, perl534Packages }:

stdenv.mkDerivation rec {
  pname = "gprename";
  version = "20220206";
  src = pkgs.fetchurl {
    url = "https://downloads.sourceforge.net/${pname}/${version}/${pname}-${version}.tar.bz2";
    sha256 = "1f99947efa8d4864afff554b92e956837c7e76870681085663ddd1c8b7524e36";
  };
  patches = [
    (fetchpatch {
      url = "https://sources.debian.org/data/main/g/gprename/20201214-0.1/debian/patches/001-Makefile.diff";
      sha256 = "???";
    })

    (fetchpatch {
      url = "https://sources.debian.org/data/main/g/gprename/20201214-0.1/debian/patches/002-gprename-path-corrections";
      sha256 = "???";
    })
  ];
  
  buildInputs = with pkgs; [
    perl
    perl534Packages.Gtk3
    perl534Packages.libintl-perl
    perl534Packages.Pango
  ];
  
}
