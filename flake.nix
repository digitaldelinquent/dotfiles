{
    description = "NixOS Configs";
    inputs = {
        nixpkgs.url = "nixpkgs/nixos-24.11";
        home-manager = {
            url = "github:nix-community/home-manager/release-24.11";
            inputs.nixpkgs.follows = "nixpkgs";
        };
        ghostty = {
            url = "github:ghostty-org/ghostty";
        };
        zsh-autosuggestions = {
            url = "github:zsh-users/zsh-autosuggestions";
            flake = false;
        };
        zsh-syntax-highlighting = {
            url = "github:zsh-users/zsh-syntax-highlighting";
            flake = false;
        };
        tmux-tpm = {
            url = "github:tmux-plugins/tpm";
            flake = false;
        };
        gtk-dracula = {
            url = "https://github.com/dracula/gtk/archive/master.zip";
            flake = false;
        };
        qt5-dracula = {
            url = "https://raw.githubusercontent.com/dracula/qt5/master/Dracula.conf";
            flake = false;
        };
        xresources-dracula = {
            url = "https://raw.githubusercontent.com/dracula/xresources/master/Xresources";
            flake = false;
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
                    home-manager.nixosModules.home-manager {
                        home-manager.useGlobalPkgs = true;
                        home-manager.useUserPackages = true;
                        home-manager.users.roelm = import ./hosts/comp22/home.nix;
                        home-manager.extraSpecialArgs = { inherit inputs; };
                    }
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
