{ config, pkgs, ... }:
{
  boot = {
    initrd.kernelModules = [ "amdgpu" ];
    kernelParams = [ "radeon.si_support=0" "amdgpu.si_support=1" ];
  };
  
  services.xserver.videoDrivers = [ "amdgpu" ];
  hardare.opengl = {
    enable = true;
    driSupport32Bit = true;
    extraPackages = with pkgs; [
      amdvlk
    ];
  };

}
