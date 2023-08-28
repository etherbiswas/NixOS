{
  config,
  pkgs,
  lib,
  ...
}: {

 hardware.opengl = {
     enable = true;
     extraPackages = with pkgs; [
       amdvlk
       rocm-opencl-icd
       rocm-opencl-runtime
       ]; 

# To enable Vulkan support for 32-bit applications, also add:
     extraPackages32 = with pkgs; [
       driversi686Linux.amdvlk
       ];
     };
  }

# Force radv
#environment.variables.AMD_VULKAN_ICD = "RADV";
