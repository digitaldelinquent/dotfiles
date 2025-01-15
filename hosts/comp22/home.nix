# Nix configuration for roelm user.

{ config, pkgs, inputs, ... }:

{
    # Home Manager needs a bit of information about you and the
    # paths it should manage.
    home.username = "roelm";
    home.homeDirectory = "/home/roelm";

    # Dotfiles
    home.file = {
        ".profile".source = ../../dots/.profile;
        ".zprofile".source = ../../dots/.zprofile;
        ".config/zsh/.zshrc".source = ../../dots/.config/zsh/.zshrc;
        ".config/zsh/plugins/zsh-autosuggestions".source = inputs.zsh-autosuggestions;
        ".config/zsh/plugins/zsh-syntax-highlighting".source = inputs.zsh-syntax-highlighting;
        ".config/starship.toml".source = ../../dots/.config/starship.toml;
        ".config/nvim/init.lua".source = ../../dots/.config/nvim/init.lua;
        ".config/nvim/lua".source = ../../dots/.config/nvim/lua;
        ".config/tmux/tmux.conf".source = ../../dots/.config/tmux/tmux.conf;
        ".config/tmux/plugins/tpm".source = inputs.tmux-tpm;
        ".config/alacritty".source = ../../dots/.config/alacritty;
        ".local/bin/lock.sh".source = ../../scripts/lock.sh;
        ".themes/Dracula".source = inputs.gtk-dracula;
        ".config/qt5ct/colors/Dracula.conf".source = inputs.qt5-dracula;
        ".Xresources".source = inputs.xresources-dracula;
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
