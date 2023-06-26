{ config, pkgs, ... }:

{
  
  environment.systemPackages = with pkgs; [
    realesrgan-ncnn-vulkan
  ];

}
