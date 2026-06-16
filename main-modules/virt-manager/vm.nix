{ config, lib, pkgs, ... }:

{
  programs.virt-manager.enable = true;

  users.groups.libvirtd.members = [ "tutturuu" ];

  virtualisation.libvirtd = {
    enable = true;

    qemu = {

      swtpm.enable = true;     
    
    };
  };

}
