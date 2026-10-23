{ config, lib, pkgs, ... }:

{

  # Kernel
  boot.kernelPackages = pkgs.linuxPackages_latest;
  
  # RAM blacklist / memory reservation
  boot.kernelParams = [
    # Reserve 35 MiB of physical RAM starting at 0x1C9D00000.
    # Intended to cover recurring MEM ERROR addresses with prefixes:
    #   1C9E - dominant error address prefix in the memory test log
    #   1CBE - second most frequent error address prefix
    # Reserved range: 0x1C9D00000 - 0x1CC000000
    "memmap=35M$0x1C9D00000"

    # Reserve 20 MiB around the reported error address 0x3A016BB54.
    # Buffer layout:
    #   10 MiB before the target address
    #   10 MiB after the target address
    #
    # Start address : 0x3A00CBB54
    # Target address: 0x3A016BB54
    # End address   : 0x3A020BB54
    "memmap=20M$0x3A00CBB54"
  ];

  # Use the systemd-boot EFI boot loader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;
  boot.loader.systemd-boot.configurationLimit = 10;

}

