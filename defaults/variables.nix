{ config, pkgs, lib, ... }:
{

  options = with lib; with types; {
    wallpaper = mkOption { type = str; };
  };
  
  config = {
   wallpaper = "/home/colin/Pictures/Wallpapers/1080/triangles.png";
  };
  
}
