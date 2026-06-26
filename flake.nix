{
  description = "NixOs";

  inputs = {

    # Nix
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";

    # Secure boot
    lanzaboote = {
      url = "github:nix-community/lanzaboote/v1.1.0";
      # Optional but recommended to limit the size of your system closure.
      inputs.nixpkgs.follows = "nixpkgs";
    };

  };

  outputs = { self, nixpkgs, lanzaboote, ... }: {

    nixosConfigurations.Tutturuu = nixpkgs.lib.nixosSystem {
      system = "x86_64-linux";

      specialArgs = {
        inherit lanzaboote;
      };

      modules = [
        ./main.nix
        ./flake-modules/lanzaboote/lanzaboote.nix
      ];
      
    };
  };
}
