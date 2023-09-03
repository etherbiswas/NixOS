{ lib, config, pkgs, ... }:

with lib;
let cfg = config.modules.gtk;

in {
  options.modules.gtk = { enable = mkEnableOption "gtk"; };
  config = mkIf cfg.enable {
    home.packages = with pkgs; [
      dconf gtk-engine-murrine gnome.gnome-themes-extra gtk3
    ];
    home.sessionVariables.GTK_THEME = "Qogir-Dark";
    gtk = {
      enable = true;
      theme = {
        name = "Qogir-Dark";
        package = pkgs.qogir-theme;
        #package = pkgs.gruvbox-gtk-theme;
      };
      cursorTheme = {
        name = "Adwaita";
      };
      iconTheme = {
          name = "Papirus-Light";
          #name = "Qogir";
          #package = pkgs.qogir-icon-theme;
          package = pkgs.papirus-icon-theme;
        };
    };
  };
}
