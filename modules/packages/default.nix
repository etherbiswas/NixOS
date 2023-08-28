{ inputs, pkgs, lib, config, python3, ... }:

with lib;
let 
  cfg = config.modules.packages;
  pyenv = ps: with ps; [
    pip
  ];

in {
    options.modules.packages = { enable = mkEnableOption "packages"; };
    config = mkIf cfg.enable {
        home.packages = with pkgs; [
          # Basic Tools
          exa
          fzf
	  htop 
	  neofetch
          ripgrep
          ffmpeg
          gnupg
          imagemagick
          libnotify
          git
	  openssl
	  gnome.seahorse
          bat
          wget
          neovim
          gcc
          cmake
          unzip
          unrar
          pavucontrol
          playerctl
          swaylock-fancy
          swaylock-effects
          brightnessctl
          inputs.hypr-contrib.packages.${pkgs.system}.grimblast
          cifs-utils
          mlocate
          nfs-utils
          openvpn
          p7zip
          # Proggrmming
          (pkgs.python3.withPackages pyenv)
          lua
          nodejs
          php
          jdk
          # GUI Applications
          alacritty
          librewolf
          brave
          wdisplays
          cinnamon.nemo-with-extensions
          cinnamon.nemo-emblems
          cinnamon.nemo-fileroller
          cinnamon.folder-color-switcher
	  nur.repos.nltch.spotify-adblock    #for installing spotify-adblock
          nur.repos.nltch.ciscoPacketTracer8 #for installing packettracer8 
        ];
      };
  }
