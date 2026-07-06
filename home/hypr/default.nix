{ config, pkgs, ... }:

{
  wayland.windowManager.hyprland.enable = true;
  services.hypridle.enable = true;
  programs.hyprlock.enable = true;

  xdg.configFile."hypr" = {
    source = ./hypr;
    recursive = true;
  };
}
