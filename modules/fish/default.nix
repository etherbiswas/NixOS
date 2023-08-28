{ pkgs, lib, config, ... }:

with lib;
let cfg = config.modules.fish;

in {
  options.modules.fish =  { enable = mkEnableOption "fish";  };
  config = mkIf cfg.enable {
    home.packages = with pkgs; [
      fish
      exa
      fzf
    ];
  };
}
