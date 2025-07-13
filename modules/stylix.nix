{
  pkgs,
  ...
}:
{
stylix = {
    enable = true;
    image =./desktop/ign_robots.png;
    polarity = "dark";
    base16Scheme = "${pkgs.base16-schemes}/share/themes/nord.yaml";
    fonts = {
      sizes = {
        applications = 11;

      };
      monospace = {
      package = pkgs.nerdfonts.override {fonts = ["JetBrainsMono"];};
        # package = pkgs.nerd-fonts.iosevka-term;
      name = "JetBrainsMono Nerd Font Mono";
      # name = "Iosevka Term";
    };
    sansSerif = {
      package = pkgs.noto-fonts;
      name = "Noto Sans";
    };
    serif = {
      package = pkgs.noto-fonts;
      name = "Noto";
    };
  };
};
}
