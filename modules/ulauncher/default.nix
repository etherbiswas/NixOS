{ pkgs, lib, config, ... }:

with lib;
let cfg = config.modules.ulauncher;

in {
    options.modules.ulauncher = { enable = mkEnableOption "ulauncher"; };
    config = mkIf cfg.enable {
	home.packages = with pkgs; [
	    ulauncher
	];

  home.file.".config/ulauncher/extensions.json".source = ./extensions.json;
  home.file.".config/ulauncher/settings.json".source = ./settings.json;
 };
}
