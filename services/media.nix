{ config, pkgs, ... }:

{

# PACKAGES
  environment.systemPackages = with pkgs; [
    gimp
    inkscape
    google-fonts
    jellyfin-media-player
    picard
    mpv
  ];

# MPV INTERFACE
  nixpkgs.overlays = [
    (self: super: {
      mpv = super.mpv.override {
        scripts = [ self.mpvScripts.modernx ];
      };
    })
  ];

}
