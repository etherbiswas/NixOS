{ config, pkgs, inputs, lib, ... }:

{

  nixpkgs.config.allowUnfree = true;
# Remove unecessary preinstalled packages
  environment.defaultPackages = [ ];

  environment.sessionVariables = { GTK_USE_PORTAL = "1"; };

  services.printing.enable = true;

  programs.fish.enable = true;

# Laptop-specific packages (the other ones are installed in `packages.nix`)
  environment.systemPackages = with pkgs; [
    acpi tlp git pciutils greetd.tuigreet
  ];

  services.greetd = {
    enable = true;
    settings = {
      default_session = {
        command = "${pkgs.greetd.tuigreet}/bin/tuigreet --time --greeting 'Welcome to NixOS!' --cmd Hyprland";
        user = "ether";
      };
    };
  };



# Adding XWayland support
  programs.hyprland.xwayland.enable = true;

# Install fonts
  fonts = {
    fonts = with pkgs; [
      jetbrains-mono
        roboto
        openmoji-color
        (nerdfonts.override { fonts = [ "FiraCode" ]; })
        (nerdfonts.override { fonts = [ "FantasqueSansMono" ];})
    ];

    fontconfig = {
      hinting.autohint = true;
      defaultFonts = {
        emoji = [ "OpenMoji Color" ];
      };
    };
  };


# Wayland stuff: enable XDG integration
  xdg = {
    icons.enable = true;
    portal = {
      enable = true;
      extraPortals = with pkgs; [
        xdg-desktop-portal-hyprland
        xdg-desktop-portal-gtk
      ];
    };
  };

# DBUS??
  
  programs.dconf.enable = true;
  services.dbus.packages = with pkgs; [ dconf ];
  services.dbus.enable = true;

  services.gvfs = {
    enable = true;
    package = lib.mkForce pkgs.gnome3.gvfs;
  };

# Nix settings, auto cleanup and enable flakes
  nix = {
    settings.auto-optimise-store = true;
    settings.allowed-users = [ "ether" ];
    gc = {
      automatic = true;
      dates = "weekly";
      options = "--delete-older-than 7d";
    };
    extraOptions = ''
      experimental-features = nix-command flakes
      keep-outputs = true
      keep-derivations = true
      '';
  };

# Boot settings: clean /tmp/, latest kernel and enable bootloader
  boot = {
    tmp.cleanOnBoot = true;
    readOnlyNixStore = false;

    loader = {
      systemd-boot.enable = true;
      systemd-boot.editor = false;
      efi.canTouchEfiVariables = true;
      timeout = 0;
    };
  };

# Set up locales (timezone and keyboard layout)
  time.timeZone = "Asia/Dhaka";
  i18n.defaultLocale = "en_US.UTF-8";
  console = {
    font = "Lat2-Terminus16";
    keyMap = "us";
  };

# Set up user and enable sudo
  users.users.ether = {
    isNormalUser = true;
    extraGroups = [ "input" "wheel" "networkmanager" ];
    initialHashedPassword = "$6$wqCHereET3WM6UIA$XeJIgGkmO2/zAkktN2JCx5hLNS3kSj6seVQBdSWoMeJ5MOrIha6B/HiDjHI4oKDKYhYVwjgQFqGpncU6OI7Ud/"; # password: d3fault
    shell = pkgs.fish;
  };

# Set up networking and secure it
  networking = {
    networkmanager.enable = true;
    firewall.enable = false; # This one is necessary to expose ports to the netwok. Usefull for smbserver, responder, http.server, ...
  };

# Set environment variables
  environment.variables = {
    NIXOS_CONFIG = "$HOME/.config/nixos/configuration.nix";
    NIXOS_CONFIG_DIR = "$HOME/.config/nixos/";
    NIXPKGS_ALLOW_INSECURE = "1";
    XDG_DATA_HOME = "$HOME/.local/share";
    GTK_RC_FILES = "$HOME/.local/share/gtk-1.0/gtkrc";
    GTK2_RC_FILES = "$HOME/.local/share/gtk-2.0/gtkrc";
    MOZ_ENABLE_WAYLAND = "1";
    EDITOR = "nvim";
    DIRENV_LOG_FORMAT = "";
    ANKI_WAYLAND = "1";
    DISABLE_QT5_COMPAT = "0";
    LIBSEAT_BACKEND = "logind";
    GTK_USE_PORTAL = "1";
    NIXPKGS_ALLOW_UNFREE = "1";
  };

# Security 
  security = {
    sudo.enable = true;
# Extra security
    protectKernelImage = true;
    pam.services.swaylock = {};
  };

# Sound (PipeWire)
  sound.enable = true; 
  hardware.pulseaudio.enable = false;
  security.rtkit.enable = true;
  services.pipewire = {
      enable = true;
      alsa.enable = true;
      alsa.support32Bit = true;
      pulse.enable = true;
    };

# Enable bluetooth, enable pulseaudio, enable opengl (for Wayland)
  hardware = {
    bluetooth.enable = true;
    opengl = {
      enable = true;
      driSupport = true;
    };
  };

# Do not touch
  system.stateVersion = "23.11";
}
