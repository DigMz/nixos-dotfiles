{ config, pkgs, ... }:

{
  home.packages = with pkgs; [ mutagen ];

  services.wayle = {
    enable = true;

    settings = {
      bar = {
        layout = [
          {
            center = [ "hyprland-workspaces" ];
            left = [
              "dashboard"
              "clock"
              "weather"
              "cava"
            ];
            monitor = "*";
            right = [
              "systray"
              "idle-inhibit"
              "microphone"
              "volume"
              "battery"
              "bluetooth"
              "network"
              "power"
            ];
            show = true;
          }
        ];
        scale = 0.9;
      };
      modules = {
        cava = {
          direction = "mirror";
          style = "wave";
        };
        hyprland-workspaces = {
          app-icons-dedupe = false;
          app-icons-show = true;
          display-mode = "none";
          min-workspace-count = 3;
          monitor-specific = false;
        };
        weather = {
          location = "Edinburg";
          units = "imperial";
        };
      };
    };
  };
}
