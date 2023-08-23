{ inputs, pkgs, config, ... }:

{
  home.stateVersion = "23.11";
  imports = [
    ./hyprland
    ./packages
    ./dunst 
    ./alacritty 
    ./waybar
    ./fish
    ./fuzzel
    ./gtk
    ./direnv
   # ./pwnixos-packages
  ];
}
