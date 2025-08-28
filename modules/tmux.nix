{
  config,
  pkgs,
  lib,
  ...
}:
{

  programs.tmux = {
    enable = true;
    keyMode = "vi";
    prefix = "C-Space";
    baseIndex = 1;
    sensibleOnTop = true;
    plugins = with pkgs; [
      tmuxPlugins.nord
    ];
    extraConfig = ''
            set -g @plugin nord
      	  set -g @nord_tmux_show_status_content "0"
            set -g renumber-windows on
            set -g status-position bottom
    '';
  };
}
