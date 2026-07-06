{ config, pkgs, ... }:

{
  xdg = {
    desktopEntries = {

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

      wallpaper_launcher = {
        categories = [
          "Wallpaper"
          "Launcher"
        ];
        exec = "~/dotfiles/nixos/home/rofi/wallpaper_launcher/wallpaper-launcher.sh";
        genericName = "wallpaper-launcher";
        name = "Wallpaper Launcher";
        terminal = false;
      };

    };
  };
}
