{ config, pkgs, ... }:

{

  services.xserver = {
    enable = true;
    displayManager.sddm.enable = true;
    desktopManager.plasma5 = {
      enable = true;
      excludePackages = with pkgs.libsForQt5; [
        oxygen
        gwenview
        okular
        khelpcenter
        elisa
        plasma-browser-integration
        print-manager
      ];
    };
  };

}
