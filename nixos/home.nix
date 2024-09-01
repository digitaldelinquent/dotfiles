{ config, pkgs, ... }:

{
    # Home Manager needs a bit of information about you and the
    # paths it should manage.
    home.username = "roelm";
    home.homeDirectory = "/home/roelm";

    # Enable zsh shell for use below
    programs.zsh.enable = true;


    # Dotfiles
    home.file = {
        ".profile".source = ~/.dotfiles/.profile;
        ".zprofile".source = ~/.dotfiles/.zprofile;
        ".config/zsh/.zshrc".source = ~/.dotfiles/zshrc/.zshrc;
        ".config/starship.toml".source = ~/.dotfiles/config/starship.toml;
        ".config/nvim".source = ~/.dotfiles/config/nvim;
        ".config/tmux".source = ~/.dotfiles/config/tmux;
        ".config/alacritty".source = ~/.dotfiles/config/alacritty;
        ".config/X11".source = ~/.dotfiles/config/X11;
        ".config/bspwm".source = ~/.dotfiles/config/bspwm;
        ".config/picom.conf".source = ~/.dotfiles/config/picom.conf;
        ".config/sxhkd".source = ~/.dotfiles/config/sxhkd;
        ".config/dunst".source = ~/.dotfiles/config/dunst;
        ".local/bin".source = ~/.dotfiles/scripts;
    };

    # This value determines the Home Manager release that your
    # configuration is compatible with. This helps avoid breakage
    # when a new Home Manager release introduces backwards
    # incompatible changes.
    #
    # You can update Home Manager without changing this value. See
    # the Home Manager release notes for a list of state version
    # changes in each release.
    home.stateVersion = "23.11";

    # Let Home Manager install and manage itself.
    programs.home-manager.enable = true;
}
