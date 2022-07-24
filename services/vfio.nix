{ config, pkgs, ... }:

{
############
### BOOT ###
############
  boot = {
    loader = {
      systemd-boot = {
        enable = true;
        configurationLimit = 3;
        editor = false;
      };
      efi = {
        canTouchEfiVariables = true;
        efiSysMountPoint = "/boot/efi";
      };
    };
    kernelParams = [ "amd_iommu=on" ];
    kernelModules = [ "vfio_virqfd" "vfio_pci" "vfio_iommu_type1" "vfio" ];
    extraModprobeConfig = "options vfio-pci ids=10de:2488,10de:228b,10ec:8161";
    
### IOMMU GROUPS AND DEVICE IDS ###
# GPU - 29 - 10de:2488,10de:228b
# NVME - 14 - 1987:5016
# ETHERNET - 28 - 10ec:8161
# WIFI - 26 - 8086:24fb
# SATA - 22 - 1022:57a4,1022:7901
# USB/BLUETOOTH - 21 - 1022:57a4,1022:1485,1022:149c
    
  };

################
### PACKAGES ###
################
  environment.systemPackages = with pkgs; [
    virt-manager
  ];
  
######################
### VIRTUALIZATION ###
######################
  virtualisation = {
      libvirtd = {
        enable = true;
        qemu = {
          package = pkgs.qemu_kvm;
          ovmf.enable = true;
          ovmf.package = pkgs.OVMFFull;
          swtpm.enable = true;
          runAsRoot = false;
        };
      };
    };

    environment.sessionVariables.LIBVIRT_DEFAULT_URI = [ "qemu:///system" ];
    users.users.colin = {
      extraGroups = [ "libvirtd" "kvm" "qemu-libvirtd" ];
    };
  
}
