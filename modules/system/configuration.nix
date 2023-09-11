{ config, pkgs, inputs, lib, ... }:

{
  nixpkgs.config.allowUnfree = true;
  nixpkgs.config.permittedInsecurePackages = [
    "openssl-1.1.1u"
  ];

# Remove unecessary preinstalled packages
  environment.defaultPackages = [ ];

  environment.sessionVariables = { GTK_USE_PORTAL = "1"; };

  environment.binsh = "${pkgs.dash}/bin/dash";

  services.gnome.gnome-keyring.enable = true;
  services.passSecretService.enable = true;
  services.passSecretService.package = pkgs.pass-secret-service;
  services.pcscd.enable = true;
  programs.gnupg.agent = {
   enable = true;
   pinentryFlavor = "curses";
   enableSSHSupport = true;
  };

  services.printing.enable = true;
  #services.physlock.enable = true;
  #services.physlock.allowAnyUser = true;

  programs.fish.enable = true;

# Systemwide packages
  environment.systemPackages = with pkgs; [
     xdg-user-dirs
     pinentry-curses
     acpi
     tlp
     pciutils
     usbutils
     greetd.tuigreet
     gtklock
     nix-prefetch-github
  ];

  services.greetd = {
    enable = true;
    settings = {
      default_session = {
        command = "${pkgs.greetd.tuigreet}/bin/tuigreet --time --greeting 'Hello Ether Biswas!' --cmd Hyprland";
        user = "ether";
      };
    };
  };

# Adding XWayland support
  programs.hyprland.xwayland.enable = true;

# Install fonts
  fonts = {
    packages = with pkgs; [
        dejavu_fonts
        jetbrains-mono
        roboto
        fira-code
        fira-code-symbols
        openmoji-color
        (nerdfonts.override { fonts = [ "FiraCode" ]; })
        (nerdfonts.override { fonts = [ "FantasqueSansMono" ];})
    ];

    fontconfig = {
      hinting.autohint = true;
      defaultFonts = {
        emoji = [ "OpenMoji Color" ];
         monospace = [ "DejaVuSans" ];
      };
    };
  };

# Enable XDG integration for wayland
  xdg = {
    icons.enable = true;
    autostart.enable = true;
    portal = {
      enable = true;
      extraPortals = with pkgs; [
        xdg-desktop-portal-hyprland
        xdg-desktop-portal-gtk
      ];
    };
  };

# DBUS
  services.dbus.enable = true;
  services.dbus.packages = with pkgs; [ dconf ];
  programs.dconf.enable = true;

  services.gvfs = {
    enable = true;
    package = lib.mkForce pkgs.gnome.gvfs;
  };

# Fstrim
  services.fstrim.enable = true;
  services.fstrim.interval = "weekly";

# Nix settings, auto cleanup and enable flakes
  nix = {
    settings.sandbox = true;
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

# Boot settings
  boot = {
    tmp.cleanOnBoot = true;
    readOnlyNixStore = false;
    kernel.sysctl = { "vm.swappiness" = 10; "vm.vfs_cache_pressure" = 50; "vm.watermark_scale_factor" = 200; "vm.dirty_ratio" = 3;};
    loader = {
      systemd-boot.enable = true;
      systemd-boot.editor = false;
      efi.canTouchEfiVariables = true;
      timeout = 5;
    };
  };

# Set up locales (Timezone and Keyboard layout)
  time.timeZone = "Asia/Dhaka";
  i18n.defaultLocale = "en_US.UTF-8";

# Set up user and enable sudo
  users.users.ether = {
    isNormalUser = true;
    extraGroups = [ "input" "wheel" "networkmanager" ];
    shell = pkgs.fish;
  };

# Set up networking and secure it
  networking = {
    networkmanager.enable = true;
    firewall.enable = false;
  };

# Set environment variables
  environment.variables = {
    NIXOS_CONFIG = "$HOME/.config/nixos/configuration.nix";
    NIXOS_CONFIG_DIR = "$HOME/.config/nixos/";
    NIXPKGS_ALLOW_INSECURE = "1";
    XDG_DESKTOP_DIR="$HOME/Desktop";
    XDG_DOCUMENTS_DIR="$HOME/Documents";
    XDG_DOWNLOAD_DIR="$HOME/Downloads";
    XDG_MUSIC_DIR="$HOME/Music";
    XDG_PICTURES_DIR="$HOME/Pictures";
    XDG_PUBLICSHARE_DIR="$HOME/Public";
    XDG_TEMPLATES_DIR="$HOME/Templates";
    XDG_VIDEOS_DIR="$HOME/Videos";
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
    pam.services.gtklock = {};
    pam.services.greetd.enableGnomeKeyring = true;
  };

# Audio (PipeWire)
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
    bluetooth.package = pkgs.bluez;
    bluetooth.enable = true;
    bluetooth.powerOnBoot = true;
    opengl = {
      enable = true;
      driSupport = true;
    };
  };

# Do not touch
  system.stateVersion = "23.11";
}
