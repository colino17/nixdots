{ lib, config, pkgs, ... }:

let inherit (import ../variables.nix) var_username; in

{

## DEFAULT CONFIGURATION (INTEGRATED GRAPHICS)
  users.users.${var_username}.extraGroups = [ "video" "render" ];
  boot = {
    kernelPackages = pkgs.linuxPackages_latest;
    initrd.kernelModules = [ "amdgpu" ];
    blacklistedKernelModules = [ "nvidia" "nvidia_uvm" "nvidia_modeset" "nvidia_drm" "nouveau" ];
  };
  services = {
    asusd.enable = true;
    power-profiles-daemon.enable = true;
    xserver.videoDrivers = [ "modesetting" ];
    udev.extraRules = ''
      ACTION=="add", SUBSYSTEM=="pci", ATTR{vendor}=="0x10de", ATTR{class}=="0x040300", ATTR{power/control}="auto", ATTR{remove}="1"
      ACTION=="add", SUBSYSTEM=="pci", ATTR{vendor}=="0x10de", ATTR{class}=="0x03[0-9]*", ATTR{power/control}="auto", ATTR{remove}="1"
    '';
  };
  environment = {
    etc."asusd/.keep".text = "";
    systemPackages = with pkgs; [
      asusctl
      brightnessctl
    ];
  };

## GAMING CONFIGURATION (DISCRETE GRAPHICS)
## USES AN OLDER KERNEL UNTIL NVIDIA DRIVERS WORK PROPERLY WITH KERNEL 7.2
  specialisation."Gaming".configuration = {
    boot = {
      kernelPackages = lib.mkForce pkgs.linuxPackages;
      blacklistedKernelModules = lib.mkForce [ "nouveau" ];
    };
    services = {
      xserver.videoDrivers = lib.mkForce [ "nvidia" ];
      udev.extraRules = lib.mkForce "";
    };
    hardware = {
      graphics = {
        enable = true;
        enable32Bit = true;
      };
      nvidia = {
        modesetting.enable = true;
        open = false;
        nvidiaSettings = true;
        nvidiaPersistenced = true;
        powerManagement.enable = true;
        prime = {
          offload.enable = true;
          offload.enableOffloadCmd = true;
          amdgpuBusId = "PCI:4:0:0";
          nvidiaBusId = "PCI:1:0:0";
        };
      };
    };
    programs.steam = {
      enable = true;
      package = pkgs.steam.override {
        extraEnv = {
          __NV_PRIME_RENDER_OFFLOAD = "1";
          __GLX_VENDOR_LIBRARY_NAME = "nvidia";
          __VK_LAYER_NV_optimus = "NVIDIA_only";
        };
      };
    };
  };

}
