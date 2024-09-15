{
    description = "NixOS Configs";
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
        vim-plug = {
            url = "https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim";
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
    outputs = { self, nixpkgs, home-manager, ... }@inputs:
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
                        home-manager.users.roelm = import ./hosts/workstation/home.nix;
                        home-manager.extraSpecialArgs = { inherit inputs; };
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
