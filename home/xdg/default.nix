{ config, pkgs, ... }:

{
  xdg = {
    desktopEntries = {
      wallpaper_launcher = {
        exec = "/home/digmz/dotfiles/nixos/home/rofi/wallpaper_launcher/wallpaper-launcher.sh";
        genericName = "wallpaper-launcher";
        name = "Wallpaper Launcher";
        terminal = false;
      };

    };
  };
}
