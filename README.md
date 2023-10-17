# Rice

1. Copy the .zprofile, .profile and .to-download files into your home directory.
2. After that copy everything over from the config directory into your .config directory.

> **NOTE:** If on non-linux machine (UNIX-like OS like MacOS) copy the .zshrc into the
> home directory. 

3. Copy the scripts dir into your .local/bin dir.
4. Pass the packages file in the .to-download dir into your system package
   manager and install all necessary files.

> **NOTE:** This config was made for yay/pacman, so you may need to download manually for some, if not all packages. 
> Many packages maybe unnecessary if on a non-linux machine (UNIX-like OS like MacOS)

5. Run the following command to install vim plug:

```
sh -c 'curl -fLo "${XDG_DATA_HOME:-$HOME/.local/share}"/nvim/site/autoload/plug.vim --create-dirs \
       https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim'
```

6. After that run `:PlugInstall` while inside the init.vim to download all vim
   plug packages.
7. Go into the .local/share/nvim/plugged/coc.nvim and run `npm ci` to resolve
   issues with coc. When coc issues are resolved you can run `:CocInstall PLUGIN
   NAME` in order to download coc language servers.

# Future To-Do's

- Automate everything in ansible to make everything idempotent and remove
  manual steps
