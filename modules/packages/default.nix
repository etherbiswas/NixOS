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
          lsof
          wlsunset
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
          cmake
          unzip
          unrar
          pavucontrol
          playerctl
          brightnessctl
          cifs-utils
          inputs.hypr-contrib.packages.${pkgs.system}.grimblast
          mlocate
          tree
          nfs-utils
          openvpn
          p7zip
          # Programming
          jq
          (pkgs.python3.withPackages pyenv)
          lua
          lua-language-server
          html-tidy
          nodePackages_latest.nodejs
          php
          jdk
          # GUI Applications
          alacritty
          librewolf
          brave
          tor-browser-bundle-bin
          qbittorrent
          wdisplays
          cinnamon.nemo-with-extensions
          cinnamon.nemo-emblems
          cinnamon.nemo-fileroller
          cinnamon.folder-color-switcher
          spicetify-cli
    	  nur.repos.nltch.spotify-adblock    #for installing spotify-adblock
          nur.repos.nltch.ciscoPacketTracer8 #for installing packettracer8
        ];
      };
  }
