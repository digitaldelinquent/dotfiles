# Dotfiles

These dotfiles use homebrew (yes on linux too) to install all cli-based
tooling. Please use your systems package manager or something like flatpak for
everything else.

1. Install all cli-based packages by running `brew bundle install` to re-install all the 
   packages listed in the brewfile

2. Next run `stow -R --adopt dots` to symlink all config files to your home directory.

2. After that run `:PlugInstall` while inside the a neovim process to download all vim
   plug packages.

3. Lastly, go into the .local/share/nvim/plugged/coc.nvim and run `npm ci` to resolve
   issues with coc. When coc issues are resolved you can run `:CocInstall PLUGIN
   NAME` in order to download coc language servers.
