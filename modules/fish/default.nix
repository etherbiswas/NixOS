{ pkgs, lib, config, ... }:

with lib;
let cfg = config.modules.fish;

in {
  options.modules.fish =  { enable = mkEnableOption "fish";  };
  config = mkIf cfg.enable {
    home.packages = with pkgs; [
      fish
      eza
      bat
      fzf
      fd
    ];

    programs.fish = {
    enable = true;
    interactiveShellInit = ''
      set fish_greeting
      set -g __fish_git_prompt_show_informative_status 1
      set -g __fish_git_prompt_hide_untrackedfiles 1
      set -g __fish_git_prompt_color_branch magenta
      set -g __fish_git_prompt_color_prefix magenta
      set -g __fish_git_prompt_color_suffix magenta
      set -g __fish_git_prompt_showupstream informative
      set -g __fish_git_prompt_char_upstream_ahead "↑ "
      set -g __fish_git_prompt_char_upstream_behind "↓ "
      set -g __fish_git_prompt_char_upstream_prefix ""
      set -g __fish_git_prompt_char_stagedstate "● "
      set -g __fish_git_prompt_char_dirtystate "✚ "
      set -g __fish_git_prompt_char_untrackedfiles "… "
      set -g __fish_git_prompt_char_conflictedstate "✖ "
      set -g __fish_git_prompt_char_cleanstate "✔ "
      set -g __fish_git_prompt_color_dirtystate blue
      set -g __fish_git_prompt_color_stagedstate yellow
      set -g __fish_git_prompt_color_invalidstate red
      set -g __fish_git_prompt_color_untrackedfiles $fish_color_normal
      set -g __fish_git_prompt_color_cleanstate green
      set --universal nvm_default_version latest
      alias ls='eza --long --color auto --icons --sort=type'
      alias la='eza -a --long --color auto --icons --sort=type'
      '';
        plugins = [
      # Enable plugins
      { name = "z"; src = pkgs.fishPlugins.z.src; }
      { name = "fzf"; src = pkgs.fishPlugins.fzf-fish.src; }
      { name = "puffer"; src = pkgs.fishPlugins.puffer.src; }
      { name = "autopair"; src = pkgs.fishPlugins.autopair.src; }
      # Manually packaging and enable a plugin
      {
      name = "nvm";
      src = pkgs.fetchFromGitHub {
        owner = "jorgebucaran";
        repo = "nvm.fish";
        rev = "c69e5d1017b21bcfca8f42c93c7e89fff6141a8a";
        hash = "sha256-LV5NiHfg4JOrcjW7hAasUSukT43UBNXGPi1oZWPbnCA=";
      };
    }
  ];
    };

  home.file.".config/fish/functions/fish_prompt.fish".source = ./fish_prompt.fish;
  };
}
