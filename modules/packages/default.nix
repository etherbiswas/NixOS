{ inputs, pkgs, lib, config, python3, ... }:

with lib;
let 
  cfg = config.modules.packages;
  pyenv = ps: with ps; [
    impacket
    dsinternals
    pypykatz
    lsassy
    pip
    ldapdomaindump
  ];

in {
    options.modules.packages = { enable = mkEnableOption "packages"; };
    config = mkIf cfg.enable {
        home.packages = with pkgs; [
          # Basic Tools
          exa
          htop 
          neofetch
          fzf
          ripgrep
          ffmpeg
          gnupg
          imagemagick
          libnotify
          git
					file
          bat
          wget
          neovim
          gcc
          cmake
          unzip
          pavucontrol
          playerctl
          swaylock-fancy
          swaylock-effects
          brightnessctl
          inputs.hypr-contrib.packages.${pkgs.system}.grimblast
          openssl
          cifs-utils
          mlocate
          nfs-utils
          openvpn
          wireguard-tools
          p7zip
          samba
          net-snmp
          tcpdump
          inetutils 
          unrar
          distrobox
          dig
          # Proggrmming
          (pkgs.python3.withPackages pyenv)
          lua
          nodejs
          php
          jdk
          # GUI Applications
          alacritty
          librewolf
          firefox-wayland
          wdisplays
          wireshark
          cherrytree
          burpsuite
          cinnamon.nemo-with-extensions
          cinnamon.nemo-emblems
          cinnamon.nemo-fileroller
          cinnamon.folder-color-switcher
          remmina
          # Offensive Tools and Applications
          nmap
          crackmapexec
          gobuster
          theharvester
          ffuf
          wfuzz
          metasploit
          exploitdb
          sqlmap
          smbmap
          arp-scan
          enum4linux
          enum4linux-ng
          dnsrecon
          testssl
          hashcat
          john
          thc-hydra
          whatweb
          evil-winrm
          crunch
          hashcat-utils
          cadaver
          wpscan
          adreaper
          certipy
          coercer
          gomapenum
          kerbrute
          nbtscanner
          smbscan
          davtest
          adenum
          proxychains-ng
          responder
        ];
      };
  }
