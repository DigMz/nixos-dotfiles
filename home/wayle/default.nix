{ config, pkgs, ... }:

{
  home.packages = with pkgs; [ mutagen ];

  services.wayle = {
    enable = true;

    settings = {
      bar = {
        bg = "transparent";
        layout = [
          {
            center = [ "hyprland-workspaces" ];
            left = [
              "dashboard"
              "idle-inhibit"
              "clock"
              "weather"
              "cava"
            ];
            monitor = "*";
            right = [
              "systray"
              "microphone"
              "volume"
              "battery"
              "bluetooth"
              "network"
              "notifications"
              "power"
            ];
            show = true;
          }
        ];
        scale = 0.9;
      };
      modules = {
        bluetooth = {
          label-max-length = 5;
        };
        cava = {
          direction = "mirror";
          style = "wave";
        };
        clock = {
          dropdown-show-seconds = true;
        };
        hyprland-workspaces = {
          app-icons-dedupe = false;
          app-icons-show = true;
          display-mode = "none";
          min-workspace-count = 3;
          monitor-specific = false;
        };
        network = {
          label-max-length = 5;
        };
        weather = {
          location = "Edinburg";
          units = "imperial";
        };
      };
      styling = {
        scale = 0.9;
        theme-provider = "pywal";
        theming-monitor = "eDP-1";
      };
      wallpaper = {
        cycling-same-image = true;
        engine-enabled = false;
      };
    };
  };
}
