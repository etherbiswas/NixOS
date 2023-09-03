{ pkgs, lib, config, ... }:

with lib;
let cfg = config.modules.dunst;

in {
    options.modules.dunst = { enable = mkEnableOption "dunst"; };
    config = mkIf cfg.enable {
	home.packages = with pkgs; [
	    dunst
	];

        services.dunst = {
            enable = true;
            settings = {
                global = {
                    origin = "top-right";
                    offset = "10x50";
                    scale = 0;
                    progress_bar = true;
                    progress_bar_height = 19;
                    progress_bar_frame_width = 4;
                    progress_bar_min_width = 150;
                    progress_bar_max_width = 300;
                    min_icon_size = 32;
                    separator_height = 2;
                    padding = 12;
                    horizontal_padding = 16;
                    text_icon_padding = 0;
                    frame_width = 4;
                    separator_color = "frame";
                    idle_threshold = 120;
                    font = "FiraCode Nerdfont 12";
                    line_height = 0;
                    format = "<b>%s</b>\n%b";
                    alignment = "left";
                    icon_position = "left";
                    startup_notification = "false";
                    corner_radius = 12;

                    frame_color = "#80aa9e";
                    background = "#282828";
                    foreground = "#e2cca9";
                    timeout = 2;
                };
            };
        };
    };
}
