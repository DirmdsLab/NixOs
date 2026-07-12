{ config, lib, pkgs, ... }:

{

  # Kernel
  boot.kernelPackages = pkgs.linuxPackages_latest;
  
  # RAM blacklist
  boot.kernelParams = [
    "memmap=35M$0x1C9D00000"
  ];

  # Use the systemd-boot EFI boot loader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;
  boot.loader.systemd-boot.configurationLimit = 10;

}

