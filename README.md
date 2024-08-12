# Dotfiles

This repo contains all my dotfiles and system setup. I use gnu stow and ansible
for the config management, but this may soon change to nix... More to come...

# Setup

1. Symlink the dotfiles via stow: `stow --adopt .`

2. Run the ansible playbook to install packages and perform some system
   configuration: `ansible-playbook -K run.yml`

3. After that run `:PlugInstall` while inside the init.vim to download all vim
   plug packages.

4. Lastly, go into the .local/share/nvim/plugged/coc.nvim and run `npm ci` to resolve
   issues with coc. When coc issues are resolved you can run `:CocInstall PLUGIN
   NAME` in order to download coc language servers.
