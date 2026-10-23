{ config, lib, pkgs, ... }:

# Mods
# Change u wallpaper (remove pixelpc)
let
  customTheme = pkgs.sddm-astronaut.override {
    embeddedTheme = "hyprland_kath";
    themeConfig = {
      Background = "/etc/nixos/main-modules/ssdm/hyprland_kath.mp4";
    };
  };

in {

  services.xserver.enable = true;

  services.displayManager.defaultSession = "hyprland";

  # Login
  services.displayManager.sddm = {
    enable = true;
    wayland.enable = false;
    package = pkgs.kdePackages.sddm;
    extraPackages = [ customTheme ];
    theme = "sddm-astronaut-theme";
  };

  # Pkgs
  environment.systemPackages = with pkgs; [

    # Mods
    customTheme

  ];

}
