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
        git clone --quiet git clone https://aur.archlinux.org/yay-bin \
            $DOWNLOADS_DIR/yay
    fi

    echo "Updating and upgrading system..."
    yay -Syuu
    echo "Update and upgrade complete!"

    echo "Installing missing packages..."
    yay -S - < packages.txt && flatpak install flathub app.zen_browser.zen
    echo "Missing packages installed!"
}

install_missing_dracula_themes() {
    echo "Checking if system is missing themes for Xresources..."

    # Xresources
    if [ ! -f "$HOME/.Xresources" ]; then
        echo "Missing Xresources, installing into home directory of $(whoami)..."
        curl https://raw.githubusercontent.com/dracula/xresources/master/Xresources \
            -o $HOME/.Xresources
        echo "Xresources installation complete!"
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
    fi

    echo "Checking if system is missing themes for gtk..."

    # GTK Theme
    if [ ! -d "$GTK_THEMES_DIR/Dracula" ]; then
        echo "Missing gtk theme, installing theme into $HOME/.themes directory..."
        git clone --quiet https://github.com/dracula/gtk \
            $GTK_THEMES_DIR/Dracula
        echo "GTK theme installation complete!"
    fi

    echo "Missing Dracula themes have been installed!"
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
    sudo systemctl enable --now iwd
    sudo systemctl enable --now bluetooth.service
    sudo systemctl enable --now ly
    echo "Networking, bluetooth and display manager services are up!"

    echo "Changing default shell for user $(whoami) to zsh..."
    chsh -s /bin/zsh $(whoami)
    echo "Default shell for user $(whoami) is now zsh!"

    echo "System is now configured, please logout and log back in"
}

main
