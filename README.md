# Dotfiles

This repo contains all my dotfiles and system setup. I use gnu stow and ansible
for the config management, but this may soon change to nix... More to come...

# Setup

> **NOTE**: Before running the commands bellow, you will need to have ansible
> installed on your system. After that the playbook will do the rest. If you do
> not have a Fedora based system, please install the packages manually and run
> `stow --adopt .` inside the repo.

1. Run the ansible playbook to install packages and perform some system
   configuration: `ansible-playbook -K run.yml`

2. After that run `:PlugInstall` while inside the a neovim process to download all vim
   plug packages.

3. Lastly, go into the .local/share/nvim/plugged/coc.nvim and run `npm ci` to resolve
   issues with coc. When coc issues are resolved you can run `:CocInstall PLUGIN
   NAME` in order to download coc language servers.
