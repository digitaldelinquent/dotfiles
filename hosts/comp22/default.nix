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

    # Disable PulseAudio
    hardware.pulseaudio.enable = false;

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
        brightnessctl # CLI tool to configure brightness of the screen
        discord # Look it up lol
        rofi # Application launcher
        podman # OCI container runtime as well, but with a more efficient approach
        libnotify # Library of tools to send notifcations (useful for testing notifications with notify-send)
        eza # Used to be exa... this is an ls alternative
        feh # CLI image viewer
        firefox # Browser of choice
        fuse # Filesystems, but in userspace!
        fzf # Cool fuzzy finding tool!
        htop # Hardware utilization viewer CLI tool
        mpv # CLI video viewer
        mullvad-vpn # VPN client for Mullvad VPN provider
        mupdf # CLI pdf viewer
        neofetch # Something cool to put in your shell rc
        tmux # Terminal multiplexer!
        pandoc # File conversions
        piper # Mouse configuration tool
        playerctl # CLI tool to control media
        starship # Cool shell prompt written in Rust
        obsidian # Awesome note taking app
        nodejs # Some stuff relies on this awful thing (some neovim plugins)
        python3 # We all know what this is
        gnome.gnome-tweaks # Used to configure GTK
        xwayland # Allow for non-wayland applications
        qt5ct # Used to configure QT
        remmina # RDP tool
        transmission # Torrenting Linux ISOs
        wireguard-tools # Utilities for connecting and using wireguard VPNs
        netbird # Homelab VPN
        netbird-ui # UI for netbird overlay VPN
        killall # Neat tool to kill processes by name
        usbutils # Contains lsusb
        zsh # Shell of choice
        dig # Cool nslookup alternative
        iw # For TMUX bar to show current network
        acpi # For TMUX bar to show battery percentage
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
            # displayManager.startx.enable = true;
			
            # Use GDM display manager
            displayManager = {
				gdm = {
					enable = true;
					wayland = true;
				};
			};
			
            # Enable Desktop Environment.
			desktopManager.gnome.enable = true;
            
            xkb = {
                layout = "us";
                variant = "";
            };
        };

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

        # Mullvad VPN
        mullvad-vpn.enable = true;
    };

    # Virtualbox stuff
    virtualisation.virtualbox.host.enable = true;
    virtualisation.virtualbox.host.enableExtensionPack = true;
    virtualisation.virtualbox.guest.enable = true;

    # Enable flakes bc they cool
    nix.settings.experimental-features = [ "nix-command" "flakes" ];

    # This value determines the NixOS release from which the default
    # settings for stateful data, like file locations and database versions
    # on your system were taken.
    system.stateVersion = "24.05";
}
