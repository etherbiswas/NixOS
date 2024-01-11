# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ config, pkgs, inputs, lib, ... }:

{
  nixpkgs.config.allowUnfree = true;
  nixpkgs.config.permittedInsecurePackages = [
    "openssl-1.1.1u"
  ];

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
    readOnlyNixStore = true;
    kernel.sysctl = { "vm.swappiness" = 10; "vm.vfs_cache_pressure" = 50; "vm.watermark_scale_factor" = 200; "vm.dirty_ratio" = 3;};
    loader = {
      efi.canTouchEfiVariables = true;
      grub.enable = true;
      grub.efiSupport = true;
      grub.device = "nodev";
      grub.useOSProber = true;
      timeout = 5;
    };
  };

# Xorg
 services.xserver = {
    enable = false;
    dpi = 180;
    layout = "us";
    videoDrivers = [ "amdgpu" ];
    deviceSection = ''
      Option "TearFree" "true"
    ''; # For amdgpu.
    libinput.enable = true;
    libinput.touchpad.naturalScrolling = true;
    displayManager.lightdm.enable = false;
    displayManager.startx.enable = false;
    windowManager.dwm.enable = false;
  };

  programs.fish.enable = true;
  programs.hyprland.enable = true;

# Adding XWayland support
  programs.xwayland.enable = true;
  programs.hyprland.xwayland.enable = true;

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
  services.ntp.enable = true;
  services.picom.enable = false;
  services.flatpak.enable = true;
  services.physlock.enable = true;
  services.physlock.allowAnyUser = true;

# Power Saving
  services.power-profiles-daemon.enable = false;
  services.tlp = {
  enable = true;
  settings = {
    CPU_BOOST_ON_AC = 1;
    CPU_BOOST_ON_BAT = 1;
    CPU_SCALING_GOVERNOR_ON_AC = "performance";
    CPU_SCALING_GOVERNOR_ON_BAT = "powersave";
  };
};
  services.auto-cpufreq.enable = true;

# Systemwide packages
  environment.systemPackages = with pkgs; [
     xdg-user-dirs
     pinentry-curses
     acpi
     tlp
     pciutils
     usbutils
     nix-prefetch-git
     nix-prefetch-github
     stdenv
     neofetch
     flameshot
  ];

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

 xdg.portal = {
    enable = true;
    wlr.enable = true;
    # gtk portal needed to make gtk apps happy
      extraPortals = with pkgs; [
        xdg-desktop-portal-hyprland
      ];
    config.common.default = "*";
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

# Set up locales (Timezone and Keyboard layout)
  time.timeZone = "Asia/Dhaka";
  i18n.defaultLocale = "en_US.UTF-8";
  console = {
    packages=[ pkgs.terminus_font ];
    font ="${pkgs.terminus_font}/share/consolefonts/ter-u28n.psf.gz";
    useXkbConfig = true; # use xkbOptions in tty.
  };

# Set up user and enable sudo
  users.users.ether = {
    isNormalUser = true;
    extraGroups = [ "input" "wheel" "networkmanager" ];
    shell = pkgs.fish;
  };

# Set up networking and secure it
  networking = {
    #hostname = "nixos";
    networkmanager.enable = true;
    firewall.enable = false;
  };

# Security
  security = {
    sudo.enable = true;
    # Extra security
    protectKernelImage = true;
    pam.services.physlock = {};
    #pam.services.lightdm.enableGnomeKeyring = true;
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

# Enable bluetooth, enable pulseaudio, enable opengl
  hardware = {
    bluetooth.package = pkgs.bluez;
    bluetooth.enable = true;
    bluetooth.powerOnBoot = true;
    opengl = {
      enable = true;
      driSupport = true;
    };
  };

 # Copy the NixOS configuration file and link it from the resulting system
  # (/run/current-system/configuration.nix). This is useful in case you
  # accidentally delete configuration.nix.
  system.autoUpgrade.enable = true;
  system.autoUpgrade.allowReboot = true;
  #system.autoUpgrade.channel = "https://channels.nixos.org/nixos-24.05";

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "23.11";
}
