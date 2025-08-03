{
  config,
  pkgs,
  lib,
  ...
}:

{
  imports = [
    ./modules/nvim_lazy/nvim_lazy.nix
    # ./modules/nvim/nvim.nix
    #    ./modules/sway.nix
    ./modules/desktop/waybar.nix
    ./modules/desktop/niri.nix
  ];

  home.sessionVariables = {
    NIXOS_OZONE_WL = "1";
    EDITOR = "nvim";
  };

  home = {
    username = "deman";
    homeDirectory = "/home/deman";
    packages = with pkgs; [
      fastfetch
      zoxide
      bat
      eza
      zathura
      fzf
      ripgrep
      transmission_4-gtk
      swaynotificationcenter
      rofi-wayland
      #      rofi-bluetooth
      #      rofi-power-menu
      #      swaylock
      wl-clipboard
      #      grim
      #      slurp
      nixfmt-rfc-style
      tutanota-desktop
      yazi
      signal-desktop
      teams-for-linux
      blueman
      swaybg
      nerd-fonts.symbols-only
      nerd-fonts.iosevka
      nerd-fonts.iosevka-term
      nerd-fonts.jetbrains-mono
      xdg-desktop-portal-gnome
      xfce.tumbler
      xwayland-satellite
    ];
  };
  gtk = {
    iconTheme.package = pkgs.nordzy-icon-theme;
    iconTheme.name = "Nordzy";
  };
  programs = {
    fuzzel.enable = true;
    # swaync.enable = true;
    swaylock.enable = true;
    fzf.enable = true;
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

  services.blueman-applet.enable = true;
  # services.network-manager-applet.enable = true;

  fonts.fontconfig.enable = true;

  programs.ghostty = {
    enable = true;
    enableFishIntegration = true;
    installVimSyntax = true;
    settings = {
      font-size = 10;
    };
  };
  services = {
    swaync.enable = true;
    # mako = {
    #   enable = true;
    #   settings = {
    #     default-timeout = "1";
    #   };
    # };
    swayidle = {
      enable = true;
    };
  };


  programs.home-manager.enable = true;
  home.stateVersion = "24.05";
}
