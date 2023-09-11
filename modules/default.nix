{ inputs, pkgs, config, ... }:

{
  home.stateVersion = "23.11";
  imports = [
    ./packages
    ./hyprland
    ./waybar
    ./alacritty
    ./fish
    ./gtk
    ./direnv
    ./dunst
    ./ulauncher
    # ./pwnixos-packages
  ];
}
