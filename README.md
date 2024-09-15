# Dotfiles!

This repo contains my confirgurations for all my nix managed systems, which
span from my homelab to my personal computer. The following sections detail how 
to provision a simple homelab using nixos and docker! For this setup the following 
services are used:

- Caddy: Used as a reverse proxy for all the services with an
  HTTP interface.
- Netbird: Used for remote access into the homelab network.
- Pi-Hole: Used for Ad-Blocking and a local DNS.
- Syncthing: Used to sync files across devices and backup files.
- VaultWarden: Used to maintain a backup copy of a bitwarden vault.

It will also go over the setup and provisioning of my personal workstation
which uses home manager to manage all my dotfiles.

This repo is under active development and will see more future updates soon.

## Homelab

In order to provision your server with the same config simply clone this repo
and run the following command:

`sudo nixos-rebuild switch --flake .`

> **NOTE**: This uses the UUIDs of my disks, please copy your hardware config
> after you installed nixos into this repo and delete the existing
> `hardware-configuration.nix`. After that the git tree will be dirty, but you
> should be able to build the system without your install being borked. You
> could also just copy your drive UUIDs into the hardware-configuration.nix file 
> and that should work too.

After that you will need to spin up the docker services using docker compose:

```
docker network create proxy
NB_SETUP_KEY=<NETBIRD_KEY> docker compose up -d
```

or if netbird container has already been added to the netbird network:

```
docker network create proxy
docker compose up -d
```

## Dotfiles

> **NOTE**: Before running the commands bellow, you will need to have nix
> installed on your system. Currently this setup only works on nixos systems.
> Standalone nix support is coming soon...

1. Build the flake onto the new system to perform some system configuration. Please use the 
   following command to build: `sudo nixos-rebuild switch --flake .`

2. After that run `:PlugInstall` while inside the a neovim process to download all vim
   plug packages.

3. Lastly, go into the .local/share/nvim/plugged/coc.nvim and run `npm ci` to resolve
   issues with coc. When coc issues are resolved you can run `:CocInstall PLUGIN
   NAME` in order to download coc language servers.
