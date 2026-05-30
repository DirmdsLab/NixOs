{
  description = "NixOs";

  inputs = {

    # Nix
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";

    # Secure boot
    lanzaboote = {
      url = "github:nix-community/lanzaboote/v1.0.0";
      # Optional but recommended to limit the size of your system closure.
      inputs.nixpkgs.follows = "nixpkgs";
    };

    # Quickshell
    quickshell = {
      url = "github:quickshell-mirror/quickshell";
      inputs.nixpkgs.follows = "nixpkgs";
    };

  };

  outputs = { self, nixpkgs, lanzaboote, quickshell, ... }: {

    nixosConfigurations.Tutturuu = nixpkgs.lib.nixosSystem {
      system = "x86_64-linux";

      specialArgs = {
        inherit lanzaboote quickshell;
      };

      modules = [
        ./main.nix
        ./flake-modules/lanzaboote/lanzaboote.nix
        ./flake-modules/quickshell/quickshell.nix
      ];
      
    };
  };
}
