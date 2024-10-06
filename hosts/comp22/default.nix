# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ config, pkgs, ... }:

{
    # Include the results of the hardware scan.
    imports = [ ./hardware-configuration.nix ];

    # Bootloader stuffies
    boot.loader.systemd-boot.enable = true;
    boot.loader.efi.canTouchEfiVariables = true;

    # Configure netowrking
    networking.hostName = "comp22"; # Define your hostname.

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
    hardware.bluetooth = {
        enable = true; # enables support for Bluetooth
        powerOnBoot = true; # powers up the default Bluetooth controller on boot
    };

    # Enable hardware acceleration for X11
    hardware.opengl.enable = true;
    hardware.opengl.driSupport = true;


    # rtkit is optional but recommended
    security.rtkit.enable = true;

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

    # Disable root
    users.users.root.hashedPassword = "!";

    # Allow unfree packages
    nixpkgs.config.allowUnfree = true;

    # Allow EOL electron in order to use Obsidian
    nixpkgs.config.permittedInsecurePackages = [
        "electron-25.9.0"
    ];

    # List packages installed in system profile.
    environment.systemPackages = with pkgs; [
        neovim # Editor of choice
        wget # Grab files from an HTTP host
        git # VCS
        docker # OCI container runtime
        docker-compose # Evaluate docker compose files
        alacritty # Terminal of choice
        alsa-utils # Low level sound stuffies
        android-tools # Tools to use for when connecting to an Android device
        arandr # GTK app to configure displays
        brightnessctl # CLI tool to configure brightness of the screen
        bspwm # Window manager of choice
        discord # Look it up lol
        rofi # Application launcher
        blueberry # GTK interface for bluetooth (from Linux Mint)
        podman # OCI container runtime as well, but with a more efficient approach
        dunst # Displays notifications from apps
        libnotify # Library of tools to send notifcations (useful for testing notifications with notify-send)
        eza # Used to be exa... this is an ls alternative
        feh # CLI image viewer and used to load wallpaper while in bspwm
        librewolf # Browser of choice
        fuse # Filesystems, but in userspace!
        fzf # Cool fuzzy finding tool!
        gnome.gnome-keyring # Needed this for Wi-Fi if I remember correctly
        virtualbox # Virtualization software (use this for spinning up kali)
        htop # Hardware utilization viewer CLI tool
        betterlockscreen # Screen locker
        maim # For screenshots
        mpv # CLI video viewer
        mullvad-vpn # VPN client for Mullvad VPN provider
        mupdf # CLI pdf viewer
        neofetch # Something cool to put in your shell rc
        tmux # Terminal multiplexer!
        networkmanagerapplet # Used to manage networks, interface sucks but best I could find
        pandoc # File conversions
        picom # Compositor
        piper # Mouse configuration tool
        playerctl # CLI tool to control media
        pavucontrol # GTK tool to control audio
        xorg.xinit # Start X11 and window manager
        xorg.xorgserver # Renders stuff on screen, really old though
        xorg.xf86inputevdev # X11 stuff
        xorg.xf86inputsynaptics # X11 stuff
        xorg.xf86inputlibinput # X11 stuff
        xorg.xf86videoati # Xll stuff
        xorg.xkill # Useful for killing frozen windows
        xidlehook # Screen locking stuff
        xautolock # Screen locking stuff
        xclip # I honestly don't remember why I need this...
        xdotool # I honestly don't remember why I need this...
        starship # Cool shell prompt written in Rust
        obsidian # Awesome note taking app
        nodejs # Some stuff relies on this awful thing (some neovim plugins)
        python3 # We all know what this is
        lxappearance # Used to configure GTK
        qt5ct # Used to configure QT
        remmina # RDP tool
        sxhkd # Keyboard shortcut daemon, built with BSPWM in mind
        transmission # Torrenting Linux ISOs
        wireguard-tools # Utilities for connecting and using wireguard VPNs
        netbird # Homelab VPN
        killall # Neat tool to kill processes by name
        usbutils # Contains lsusb
        zsh # Shell of choice
        dig # Cool nslookup alternative
        solaar # For configuring logitech mice
        prettyping # Pretty ping alternative
        bat # Pretty cat alternative
        syncthing # Cool way to sync files yo!
        stow # Dotfile manager (just auto symlinks pretty much)
    ];

    # Install fonts
    fonts.packages = with pkgs; [
        (nerdfonts.override { fonts = [ "Hack" ]; })
    ];

    # Configure services
    services = {
        # Configure X11
        xserver = {
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

        # Configure PipeWire
        pipewire = {
            enable = true;
            alsa.enable = true;
            alsa.support32Bit = true;
            pulse.enable = true;
        };

        # Configure printing
        printing.enable = true;

        avahi = {
            enable = true;
            openFirewall = true;
        };

        # Enable netbird
        netbird.enable = true;

        # Configure Syncthing Service
        syncthing = {
            enable = true;
            user = "roelm";
            dataDir = "/home/roelm"; 
            configDir = "/home/roelm/.config/syncthing";
        };
    };

    # Enable flakes bc they cool
    nix.settings.experimental-features = [ "nix-command" "flakes" ];

    # This value determines the NixOS release from which the default
    # settings for stateful data, like file locations and database versions
    # on your system were taken.
    system.stateVersion = "23.11";
}
