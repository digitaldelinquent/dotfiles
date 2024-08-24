# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ config, pkgs, ... }:

{
    imports =
        [ # Include the results of the hardware scan.
            ./hardware-configuration.nix
        ];

    # Bootloader stuffies
    boot.loader.systemd-boot.enable = true;
    boot.loader.efi.canTouchEfiVariables = true;

    networking.hostName = "comp22"; # Define your hostname.

    # Enable networking
    networking.networkmanager.enable = true;

    networking.nameservers = [ "192.168.1.241" "1.1.1.1" ];

    # Firewall configuration
    networking.firewall = {
        enable = true;
        allowedTCPPorts = [ 
            22000 # Syncthing
        ];
        allowedUDPPorts = [
            22000 # Syncthing
            21027 # Syncthing
        ];
    };

    # Enable bluetooth
    hardware.bluetooth.enable = true; # enables support for Bluetooth
    hardware.bluetooth.powerOnBoot = true; # powers up the default Bluetooth controller on boot

    # Set your time zone.
    time.timeZone = "America/Los_Angeles";

    # Select internationalisation properties.
    i18n.defaultLocale = "en_US.UTF-8";

    i18n.extraLocaleSettings = {
        LC_ADDRESS = "en_US.UTF-8";
        LC_IDENTIFICATION = "en_US.UTF-8";
        LC_MEASUREMENT = "en_US.UTF-8";
        LC_MONETARY = "en_US.UTF-8";
        LC_NAME = "en_US.UTF-8";
        LC_NUMERIC = "en_US.UTF-8";
        LC_PAPER = "en_US.UTF-8";
        LC_TELEPHONE = "en_US.UTF-8";
        LC_TIME = "en_US.UTF-8";
    };

    # Enable zsh shell for use below
    programs.zsh.enable = true;

    # Define a user account. Don't forget to set a password with ‘passwd’.
    users.users.roelm = {
       isNormalUser = true;
       description = "Roel Mendoza";
       extraGroups = [ "networkmanager" "wheel" ];
       packages = with pkgs; [];
       shell = pkgs.zsh;
    };

    # Allow unfree packages
    nixpkgs.config.allowUnfree = true;

    # Allow EOL electron in order to use Obsidian
    nixpkgs.config.permittedInsecurePackages = [
        "electron-25.9.0"
    ];

    # List packages installed in system profile.
    environment.systemPackages = with pkgs; [
        neovim
        wget
        git
        docker
        docker-compose
        alacritty
        alsa-utils
        android-tools
        arandr
        blueman
        brightnessctl
        bspwm
        discord
        rofi
        podman
        dunst
        libnotify
        eza
        feh
        librewolf
        fuse
        fzf
        gnome.gnome-keyring
        virtualbox
        htop
        betterlockscreen
        maim
        mpv
        mullvad-vpn
        mupdf
        neofetch
        neovim
        tmux
        networkmanagerapplet
        pandoc
        picom
        piper
        playerctl
        pavucontrol
        xorg.xinit
        xorg.xorgserver
        xorg.xf86inputevdev
        xorg.xf86inputsynaptics
        xorg.xf86inputlibinput
        xorg.xf86videoati
        xidlehook
        starship
        obsidian
        nodejs
        python3
        lxappearance
        qt5ct
        remmina
        sxhkd
        transmission
        wireguard-tools
        xautolock
        killall
        xclip
        xdotool
        zsh
        dig
        solaar
        prettyping
        bat
        syncthing
        stow
    ];

    # Install fonts
    fonts.packages = with pkgs; [
        (nerdfonts.override { fonts = [ "Hack" ]; })
    ];

    # Configure X11
    services.xserver = {
        enable = true;
        videoDrivers = [ "amdgpu" ];
        displayManager.startx.enable = true;
        layout = "us";
        xkbVariant = "";

        # Libinput configuration
        libinput = {
            enable = true;

            # Disable mouse acceleration
            mouse = {
                accelProfile = "flat";
            };

            # Configure touchpad
            touchpad = {
                accelProfile = "flat";
                tapping = true;
                naturalScrolling = true;
                scrollMethod = "twofinger";
                disableWhileTyping = false;
                clickMethod = "clickfinger";
            };
        };
    };

    # Enable hardware acceleration for Xserver
    hardware.opengl.enable = true;
    hardware.opengl.driSupport = true;

    # rtkit is optional but recommended
    security.rtkit.enable = true;

    # Configure PipeWire
    services.pipewire = {
        enable = true;
        alsa.enable = true;
        alsa.support32Bit = true;
        pulse.enable = true;
    };

    # Syncthing Service
    services.syncthing = {
        enable = true;
        user = "roelm";
        dataDir = "/home/roelm"; 
        configDir = "/home/roelm/.config/syncthing";
    };

    # Enable flakes bc they cool
    nix.settings.experimental-features = [ "nix-command" "flakes" ];

    # This value determines the NixOS release from which the default
    # settings for stateful data, like file locations and database versions
    # on your system were taken.
    system.stateVersion = "23.11";
}
