{ config, pkgs, ... }:

{

# PACKAGES
  environment.systemPackages = with pkgs; [
    gimp
    inkscape
    google-fonts
    picard
#    mpv
  ];


# MPV INTERFACE
  nixpkgs.overlays = [
    (self: super: {
      mpv = super.mpv.override {
        scripts = [ self.mpvScripts.modernz ];
      };
    })
  ];

}
