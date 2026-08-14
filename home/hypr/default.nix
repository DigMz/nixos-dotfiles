{ config, pkgs, ... }:

{
  wayland.windowManager.hyprland.enable = true;
  services.hypridle.enable = true;
  services.hyprpolkitagent.enable = true;
  programs.hyprlock.enable = true;
  programs.hyprshot.enable = true;

  xdg.configFile."hypr" = {
    source = ./config;
    recursive = true;
  };

  home.packages = with pkgs; [
    playerctl
  ];
}
