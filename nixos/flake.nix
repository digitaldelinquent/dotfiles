{
    description = "NixOS Workstation";
    inputs = {
        nixpkgs.url = "nixpkgs/nixos-23.11";
        home-manager = {
            url = "github:nix-community/home-manager";
            inputs.nixpkgs.follows = "nixpkgs";
        };
    };
    outputs = { self, nixpkgs, home-manager, ... }:
        let
            lib = nixpkgs.lib;
        in {
        nixosConfigurations.comp22 = lib.nixosSystem {
            system = "x86_64-linux";
            modules = [ 
                ./configuration.nix 
                home-manager.nixosModules.home-manager {
                    home-manager.useGlobalPkgs = true;
                    home-manager.useUserPackages = true;
                    home-manager.users.roelm = import ./home.nix;
                    # Optionally, use home-manager.extraSpecialArgs to pass
                    # arguments to home.nix
                }
            ];
        };
    };

}
