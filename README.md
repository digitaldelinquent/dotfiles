# Dotfiles

These dotfiles use homebrew and pacman to install all cli-based tooling. If you are running on linux,
please run the `install_linux.sh` script and skip to step 3.

1. Install all cli-based packages by running `brew bundle install` to re-install all the 
   packages listed in the brewfile

2. Next run `stow -R --adopt dots` to symlink all config files to your home directory.

3. After that run `:PlugInstall` while inside the a neovim process to download all vim
   plug packages.

4. Lastly, go into the .local/share/nvim/plugged/coc.nvim and run `npm ci` to resolve
   issues with coc. When coc issues are resolved you can run `:CocInstall PLUGIN
   NAME` in order to download coc language servers.
