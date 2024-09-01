{ config, pkgs, ... }:

{
    # Home Manager needs a bit of information about you and the
    # paths it should manage.
    home.username = "roelm";
    home.homeDirectory = "/home/roelm";


    # Dotfiles
    home.file = {
        ".profile".source = ../.profile;
        ".zprofile".source = ../.zprofile;
        ".config/zsh/.zshrc".source = ../config/zshrc/.zshrc;
        ".config/starship.toml".source = ../config/starship.toml;
        ".config/nvim".source = ../config/nvim;
        ".config/tmux".source = ../config/tmux;
        ".config/alacritty".source = ../config/alacritty;
        ".config/X11".source = ../config/X11;
        ".config/bspwm".source = ../config/bspwm;
        ".config/picom.conf".source = ../config/picom.conf;
        ".config/sxhkd".source = ../config/sxhkd;
        ".config/dunst".source = ../config/dunst;
        ".local/bin".source = ../scripts;
    };

    programs.git = {
        enable = true;
        userEmail = "6541669-digital_delinquent@users.noreply.gitlab.com";
        userName = "digital_delinquent";
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
