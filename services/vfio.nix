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
    extraModprobeConfig = "options vfio-pci ids=10de:13c0,10de:0fbb";
  };

################
### PACKAGES ###
################
  environment.systemPackages = with pkgs; [
    virt-manager
    win-virtio
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

    environment.etc = {
      "ovmf/edk2-x86_64-secure-code.fd" = {
        source = config.virtualisation.libvirtd.qemu.package + "/share/qemu/edk2-x86_64-secure-code.fd";
      };

      "ovmf/edk2-i386-vars.fd" = {
        source = config.virtualisation.libvirtd.qemu.package + "/share/qemu/edk2-i386-vars.fd";
        mode = "0644";
        user = "libvirtd";
      };
    };

    environment.sessionVariables.LIBVIRT_DEFAULT_URI = [ "qemu:///system" ];
    users.users.colin = {
      extraGroups = [ "libvirtd" "kvm" "qemu-libvirtd" ];
    };
  
}
  
  
  
