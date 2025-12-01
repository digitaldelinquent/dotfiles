#! /usr/bin/env bash

DOWNLOADS_DIR="$HOME/Downloads"
GTK_THEMES_DIR="$HOME/.themes"

create_missing_dirs() {
    echo "Creating missing directories if they don't exist..."
    mkdir -p $DOWNLOADS_DIR
    mkdir -p $GTK_THEMES_DIR
    mkdir -p $XDG_CONFIG_HOME
    mkdir -p $XDG_DATA_HOME
    mkdir -p $XDG_CACHE_HOME
    mkdir -p $XDG_STATE_HOME
    echo "Missing directories should now be in place!"
}

install_missing_packages() {
    if [ ! command -v yay >/dev/null 2>&1 ]; then
        echo "Missing yay, cloning into Downloads and installing..."

        if [ ! command -v git >/dev/null 2>&1 ]; then
            echo "Missing git, installing git first before installing yay..."
            sudo pacman -S git
            echo "Git is installed!"
        fi

        rm -rf $DOWNLOADS_DIR/yay
        git clone --quiet https://aur.archlinux.org/yay-bin \
            $DOWNLOADS_DIR/yay
        makepkg -si -D $DOWNLOADS_DIR/yay

        echo "Yay is installed!"
    fi

    echo "Updating and upgrading system..."
    yay -Syuu
    echo "Update and upgrade complete!"

    echo "Installing missing packages..."
    yay -S - < packages.txt && flatpak install flathub app.zen_browser.zen
    echo "Missing packages installed!"

    # Configure downloads dir for zen browser
    flatpak override --user --filesystem=~/Downloads app.zen_browser.zen
    echo "Downloads directory configured for zen browser"
}

install_missing_dracula_themes() {
    echo "Checking if system is missing themes for Xresources..."

    missing_theme_count=0
    declare -a missing_themes

    # Xresources
    if [ ! -f "$HOME/.Xresources" ]; then
        echo "Missing Xresources, installing into home directory of $(whoami)..."
        curl https://raw.githubusercontent.com/dracula/xresources/master/Xresources \
            -o $HOME/.Xresources
        echo "Xresources installation complete!"

        ((++missing_theme_count))
        missing_themes+="Xresources"
    fi

    echo "Checking if system is missing themes for rofi..."

    # Rofi
    if [ ! -f "$XDG_CONFIG_HOME/rofi/config.rasi" ]; then
        echo "Missing rofi theme, installing into config dir of $XDG_CONFIG_HOME..."

        # Delete folders in case they exist in Downloads
        rm -rf $DOWNLOADS_DIR/rofi &&
        git clone --quiet https://github.com/dracula/rofi \
            $DOWNLOADS_DIR/rofi

        cp $DOWNLOADS_DIR/rofi/theme/config1.rasi $XDG_CONFIG_DIR/rofi/config.rasi
        echo "Rofi theme installation complete!"

        ((++missing_theme_count))
        missing_themes+="rofi"
    fi

    echo "Checking if system is missing themes for gtk..."

    # GTK Theme
    if [ ! -d "$GTK_THEMES_DIR/Dracula" ]; then
        echo "Missing gtk theme, installing theme into $HOME/.themes directory..."
        git clone --quiet https://github.com/dracula/gtk \
            $GTK_THEMES_DIR/Dracula
        echo "GTK theme installation complete!"

        ((++missing_theme_count))
        missing_themes+="gtk"
    fi

    if [ $missing_theme_count -eq 0 ]; then
        echo "No Dracula themes were missing!"
    else
        echo "Installed $missing_theme_count missing dracula themes ($missing_themes)!"
    fi
}

configure_networking () {
    sudo systemctl enable --now NetworkManager
    sudo systemctl enable --now systemd-resolved

    sudo ln -sf /run/systemd/resolve/stub-resolv.conf /etc/resolv.conf
    echo "Symlinked systemd-resolved conf as /etc/resolv.conf"

    sudo echo "[main]\ndns=systemd-resolved" >> /etc/NetworkManager/conf.d
    echo "Default DNS is now systemd-resolved"

    sudo systemctl enable --now tailscaled
}

main() {
    source dots/.profile

    create_missing_dirs
    install_missing_packages
    install_missing_dracula_themes

    echo "Stowing dots..."
    stow -R --adopt dots
    echo "Dots are now symlinked!"

    echo "Enabling some services..."
    configure_networking
    sudo systemctl enable --now bluetooth.service
    sudo systemctl enable --now ly
    echo "Networking, bluetooth and display manager services are up!"

    echo "Changing default shell for user $(whoami) to zsh..."
    chsh -s /bin/zsh $(whoami)
    rm -f $HOME/.bash*
    echo "Default shell for user $(whoami) is now zsh!"

    echo "System is now configured, please logout and log back in"
}

main
