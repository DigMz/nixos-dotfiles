{ config, pkgs, ... }:

{
  home.packages = with pkgs; [ 
    kdePackages.qtsvg
    kdePackages.qtimageformats
    kdePackages.qtmultimedia
    kdePackages.qt5compat
  ];

  programs.quickshell = {
    enable = true;
  };

  xdg.configFile."quickshell" = {
    source = ./config;
    recursive = true;
  };

  # wallpaper-launcher only works with both hyprland and rofi
  xdg = {
    desktopEntries = {
      wallpaper_launcher = {
        exec = "quickshell -c wallpaper_select";
        genericName = "wallpaper-launcher";
        name = "Wallpaper Launcher";
        terminal = false;
      };

    };
  };
}
