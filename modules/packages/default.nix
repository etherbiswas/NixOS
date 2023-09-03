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
          ulauncher
          lxappearance
          exa
    	  htop
  	      neofetch
          ffmpeg
          gnupg
          imagemagick
          libnotify
          git
          github-desktop
          yt-dlp
	      openssl
	      gnome.seahorse
          bat
          wget
          nano
          vim
          neovim
          fzf
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
