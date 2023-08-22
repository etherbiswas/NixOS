{ inputs, pkgs, config, ... }:

{
  home.stateVersion = "23.05";
  imports = [
    ./hyprland
    ./packages
    ./dunst 
    ./alacritty 
    ./waybar
    ./zsh
    ./fuzzel
    ./gtk
    ./direnv
   # ./pwnixos-packages
  ];
}
