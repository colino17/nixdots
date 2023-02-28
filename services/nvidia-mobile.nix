{ config, pkgs, ... }:

{
  services.xserver.videoDrivers = [ "nvidia" ];
  hardware.opengl.enable = true;
  hardware.opengl.driSupport32Bit = true;
  services.switcherooControl.enable = true;
  hardware.nvidia.prime = {
    offload.enable = true;
    amdgpuBusId = "PCI:4:00:0";
    nvidiaBusId = "PCI:1:00:0";
  };
}
