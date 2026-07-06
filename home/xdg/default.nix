{ config, pkgs, ... }:

{
  xdg = {
    desktopEntries = {
      wallpaperLauncher = {
        categories = [
          "Wallpaper"
          "Launcher"
        ];
        exec = "~/dotfiles/nixos/home/rofi/wallpaper_launcher/wallpaper-launcher.sh";
        genericName = "Wallpaper Launcher";
        name = "Wallpaper Launcher";
        terminal = false;
      };
    };
    firefox = {
      categories = [
        "Network"
        "WebBrowser"
      ];
      exec = "firefox %U";
      genericName = "Web Browser";
      mimeType = [
        "text/html"
        "text/xml"
      ];
      name = "Firefox";
      terminal = false;
    };
  };
}
