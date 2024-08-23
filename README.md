# Dotfiles

This repo contains all my dotfiles and system setup. I use gnu stow and nix
for the config management. This may change from stow to home manager in the
near future...

# Setup

> **NOTE**: Before running the commands bellow, you will need to have nix
> installed on your system.

1. Build the flake onto the new system to perform some system configuration. Please use the 
   following command to build: `sudo nixos-rebuild switch --flake .`

2. Next is to run `stow --adopt .` in order to symlink the dotfiles

3. After that run `:PlugInstall` while inside the a neovim process to download all vim
   plug packages.

4. Lastly, go into the .local/share/nvim/plugged/coc.nvim and run `npm ci` to resolve
   issues with coc. When coc issues are resolved you can run `:CocInstall PLUGIN
   NAME` in order to download coc language servers.
