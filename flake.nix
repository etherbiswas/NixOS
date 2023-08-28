{
  description = "NixOS Dotfiles focused on Productivity.";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    nur = {
      url = "github:nix-community/NUR";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    hypr-contrib.url = "github:hyprwm/contrib";
  };

  outputs = { nixpkgs, home-manager, nur, ... }@inputs:
    let 
      system = "x86_64-linux";
      pkgs = nixpkgs.legacyPackages.${system}; 
      lib = nixpkgs.lib;

      mkSystem = pkgs: system: hostname:
        pkgs.lib.nixosSystem {
          system = system;
          modules = [
          { networking.hostName = hostname; }
          ./modules/system/configuration.nix 
            (./. + "/hosts/${hostname}/hardware-configuration.nix")
	          (./. + "/hosts/${hostname}/default.nix") # For additional configuration read this file (nvidia, intel, ...).
            home-manager.nixosModules.home-manager
            {
              home-manager = {
                useUserPackages = true;
                useGlobalPkgs = true;
                extraSpecialArgs = { inherit inputs; };
                users.ether = (./. + "/hosts/${hostname}/user.nix");
              };
              nixpkgs.overlays = [
                nur.overlay
              ];
            }
          ];
          specialArgs = {inherit inputs; };
        };

    in {
      nixosConfigurations = {
        b450mh = mkSystem inputs.nixpkgs "x86_64-linux" "b450mh"; # Change 'b450mh' here and in the name folder inside hosts to change the hostname.
      };
    };
}
