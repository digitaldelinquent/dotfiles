{
    description = "NixOS Workstation";
    inputs = {
        nixpkgs.url = "nixpkgs/nixos-23.11";
        home-manager = {
            url = "github:nix-community/home-manager/release-23.11";
            inputs.nixpkgs.follows = "nixpkgs";
        };
        zsh-autosuggestions = {
            url = "github:zsh-users/zsh-autosuggestions";
            flake = false;
        };
        zsh-syntax-highlighting = {
            url = "github:zsh-users/zsh-syntax-highlighting";
            flake = false;
        };
    };
    outputs = { self, nixpkgs, home-manager, ... }@inputs:
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
                    home-manager.extraSpecialArgs = { inherit inputs; };
                }
            ];
        };
    };

}
