{ inputs, pkgs, config, ... }:

{
  home.stateVersion = "23.11";
  imports = [
    ./packages
    ./alacritty
    ./fish
    ./gtk
    ./dunst
    ./hyprland
    ./waybar
    # ./pwnixos-packages
  ];
}
