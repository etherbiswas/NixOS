{ inputs, pkgs, config, ... }:

{
  home.stateVersion = "23.11";
  imports = [
    ./hyprland
    ./packages
    ./dunst 
   # ./kitty
    ./alacritty
    ./waybar
    # ./zsh
    ./fish
    ./fuzzel
    ./gtk
    ./direnv
    # ./pwnixos-packages
  ];
}
