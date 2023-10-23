# Rice

1. Copy/symlink the .zprofile, .profile and .to-download files into your home directory.
2. After that copy/symlink everything over from the config directory into your .config directory.

> **NOTE:** If on non-linux machine (UNIX-like OS like MacOS) copy the .zshrc into the
> home directory. 

3. Copy/symlink the scripts dir into your .local/bin dir.
4. Pass the packages file in the .to-download dir into your system package
   manager and install all necessary files.

> **NOTE:** This config was made for yay/pacman, so you may need to manually download some, if not all packages. 
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
8. Install the betterlockscreen screen locker by running the following command:

```
wget https://raw.githubusercontent.com/betterlockscreen/betterlockscreen/main/install.sh -O - -q | bash -s user
```

9. Lastly clone the xdo repo and run the following in order to use mupdf and
   feh:

```
git clone https://github.com/baskerville/xdo.git
cd xdo
sudo make install
```

## Future To-Do's

- Automate everything in ansible to make everything idempotent and remove
  manual steps
