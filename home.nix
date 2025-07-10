{ config, pkgs, lib, ... }:

{
  imports = [
#    ./modules/nvim/nvim.nix
#    ./modules/sway.nix
  ];

  home = {
    username = "deman";
    homeDirectory = "/home/deman";
    packages = with pkgs; [
      fastfetch
#      feh
      zoxide
      bat
     xfce.thunar
     xfce.thunar-volman
#      gopls
#      go
      eza
      zathura
      fzf
      ripgrep
#      transmission_4-gtk
#      swaynotificationcenter
#      rofi-wayland
#      rofi-bluetooth
#      rofi-power-menu
#      waybar
#      swaylock
#      swaybg
#      swayidle
     wl-clipboard
#      grim
#      nwg-displays
#      slurp
      tutanota-desktop
#      yazi
      signal-desktop
      teams-for-linux
      swaybg
      xdg-desktop-portal-gnome
    ];
  };
  gtk = {
    iconTheme.package = pkgs.nordzy-icon-theme;
    iconTheme.name = "Nordzy";
  };
  programs = {
    alacritty.enable = true;
    fuzzel.enable = true;
    waybar.enable = true;
    swaylock.enable = true;
    starship.enable = true;
    direnv = {
      enable = true;
      nix-direnv.enable = true;
      config = {
        global = {
          hide_env_diff = true;
        };
      };
    };
    git = {
      enable = true;
      package = pkgs.gitAndTools.gitFull;
      userName = "deman9";
      userEmail = "andem@tuta.io";
      extraConfig = {
        core.editor = "nvim";
        init.defaultBranch = "main";
      };
    };

  };

  fonts.fontconfig.enable = true;

services = {
   swaync.enable = true;
    # mako.enable = true;
    swayidle = {
      enable = true;
    };
  };

    programs.home-manager.enable = true;
    home.stateVersion = "24.05";
}
