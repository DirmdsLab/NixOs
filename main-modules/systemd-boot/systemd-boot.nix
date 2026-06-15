{ config, lib, pkgs, ... }:

{

  # Kernel
  boot.kernelPackages = pkgs.linuxPackages_latest;
  

  # Use the systemd-boot EFI boot loader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;
  boot.loader.systemd-boot.configurationLimit = 10;

}

