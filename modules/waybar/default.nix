{  inputs, lib, config, pkgs, ... }:

with lib;
let cfg = config.modules.waybar;

in {
  options.modules.waybar = { enable = mkEnableOption "waybar"; };
  config = mkIf cfg.enable {

    programs.waybar = {
      enable = true;
      package = pkgs.waybar.overrideAttrs (oldAttrs: {
          mesonFlags = oldAttrs.mesonFlags ++ [ "-Dexperimental=true" ];
          });
    };

    home.file.".config/waybar/style.css".source = ./style.css;
    home.file.".config/waybar/colors.css".source = ./colors.css;
    home.file.".config/waybar/config".source = ./config;
  };
}
