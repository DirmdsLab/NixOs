{ config, lib, pkgs, ... }:

{

  # Kernel
  boot.kernelPackages = pkgs.linuxPackages_6_12;
  

  # Use the systemd-boot EFI boot loader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;
  boot.loader.systemd-boot.configurationLimit = 10;

}

