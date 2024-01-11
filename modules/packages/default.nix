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
          rofi
          flatpak
          gnome.gnome-software
          # Basic Tools
          lsof
          blueman
          lxappearance
      	  htop
      	  neofetch
          ffmpeg
          gnupg
          imagemagick
          gimp
          libnotify
          git
          github-desktop
          yt-dlp
    	    openssl
    	    gnome.seahorse
          wget
          nano
          vim
          neovim
          ripgrep
          gcc
          gnumake
          cmake
          unzip
          unrar
          pavucontrol
          playerctl
          spicetify-cli
          brightnessctl
          wlsunset
          cifs-utils
          mlocate
          tree
          nfs-utils
          p7zip
          # Programming
          jq
          (pkgs.python3.withPackages pyenv)
          lua
          lua-language-server
          html-tidy
          nodePackages_latest.nodejs
          php
          cargo
          jdk
          # GUI Applications
          alacritty
          xfce.thunar
          firefox-esr
          brave
          tor-browser-bundle-bin
          qbittorrent
    	    #nur.repos.nltch.spotify-adblock    #for installing spotify-adblock
          #nur.repos.nltch.ciscoPacketTracer8 #for installing packettracer8
        ];
      };
  }
