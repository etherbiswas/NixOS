{ config, lib, inputs, pkgs, ...}:

{
    imports = [
    ../../modules/default.nix
    ];
    config.modules = {
      direnv.enable = true;
      packages.enable = true;
      hyprland.enable = true;
      waybar.enable = true;
      gtk.enable = true;
      alacritty.enable = true;
      fish.enable = true;
      dunst.enable = true;
      ulauncher.enable = true;
      #pwnixos-packages.enable = false;
    };
}
