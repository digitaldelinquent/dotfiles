{
    description = "NixOS Configs";
    inputs = {
        nixpkgs.url = "nixpkgs/nixos-24.11";
        ghostty = {
            url = "github:ghostty-org/ghostty";
        };
    };
    outputs = { self, nixpkgs, home-manager, ghostty, ... }@inputs:
        let
            system = "x86_64-linux";
            lib = nixpkgs.lib;
        in {
        nixosConfigurations = {
            comp22 = lib.nixosSystem {
                inherit system;
                modules = [ 
                    ./hosts/comp22
                    {
                        environment.systemPackages = [
                            ghostty.packages.x86_64-linux.default
                        ];
                    }
                ];
            };
            homelab = lib.nixosSystem {
                inherit system;
                modules = [ ./hosts/homelab ];
            };
        };
    };

}
