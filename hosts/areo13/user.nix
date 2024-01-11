{ config, lib, inputs, pkgs, ...}:

{
    imports = [
    ../../modules/default.nix
    ];
    config.modules = {
      packages.enable = true;
      gtk.enable = true;
      alacritty.enable = true;
      fish.enable = true;
      dunst.enable = true;
      hyprland.enable = true;
      waybar.enable = true;
    };
}
