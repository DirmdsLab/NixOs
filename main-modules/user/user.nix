{ config, lib, pkgs, ... }:

{

  # User account
  users.users.tutturuu = {
    isNormalUser = true;
    extraGroups = [ "networkmanager" "wheel" ]; 

    packages = with pkgs; [

      # File
      file-roller
      yazi
      fzf

      # Android-Tools
      android-tools
      scrcpy

      # Wallpaper
      mpvpaper

      # ss
      grim
      slurp

      # Player
      mpv
      ffmpeg-full

      # Image
      loupe

      # Tool mpvpaper
      socat
      jq

      # UwU
      cava
      tty-clock

      # Dev
      vscodium
   
      # Terminal
      foot
      starship

      # Themes
      nwg-look

      # Translate
      translate-shell

      # Sosmed
      discord

      # Tool
      moonlight-qt
      obs-studio

      # chromium
      chromium

    ];
    
    # Default user terminal
    shell = pkgs.fish;

  };

  # Unfree
  nixpkgs.config.allowUnfreePredicate = pkg: builtins.elem (lib.getName pkg) [
    "discord"
  ];

}
