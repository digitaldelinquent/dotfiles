# Rice

1. Symlink the dotfiles via stow: `stow --adopt .`
2. Pass the packages file in the .to-download dir into your system package
   manager and install all necessary files. (If you are using the dnf package
   manager, use the `reinstall` function in the shell.)

> **NOTE:** This config was made for dnf, so you may need to use a different package name,
> or manually download some packages from their respective websites.
> Many packages maybe unnecessary if on a non-linux machine (UNIX-like OS like MacOS)

3. Run the following command to install vim plug:

```
sh -c 'curl -fLo "${XDG_DATA_HOME:-$HOME/.local/share}"/nvim/site/autoload/plug.vim --create-dirs \
       https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim'
```

4. After that run `:PlugInstall` while inside the init.vim to download all vim
   plug packages.
5. Go into the .local/share/nvim/plugged/coc.nvim and run `npm ci` to resolve
   issues with coc. When coc issues are resolved you can run `:CocInstall PLUGIN
   NAME` in order to download coc language servers.
6. Install starship shell prompt via install script:

```
curl -sS https://starship.rs/install.sh | sh
```

7. Clone the xdo repo and run the following in order to use mupdf and
   feh:

```
git clone https://github.com/baskerville/xdo.git
cd xdo
sudo make install
```

8. Lastly, to utilize the zsh extensions, you need to install the plugins into your
    system as follows:

```
mkdir $HOME/.config/zsh/plugins
git clone https://github.com/zsh-users/zsh-autosuggestions\
    ~/.config/zsh/plugins/zsh-autosuggestions
git clone https://github.com/zsh-users/zsh-syntax-highlighting.git\
    ~/.config/zsh/plugins/zsh-syntax-highlighting
```

## Future To-Do's

- [ ] Automate everything in ansible to make everything idempotent and remove
  manual steps.
  - Ansible playbook has been created. Basic functionality has been implemented
    and merged into the master branch, still needs work to automate other items
    in the list above.
- [ ] Possibly moveover to a wayland based WM/Compositor. Possible considerations
  are river and hyprland.
