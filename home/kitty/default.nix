{ config, pkgs, ... }:

{
  programs.kitty = {
    enable = true;
    font = {
      name = "DejaVuSansMono";
      size = 16;
    };
    environment = {
      "EDITOR" = "nvim";
    };
    shellIntegration.mode = "no-cursor";
    settings = {
      background_opacity = "0.85";
      background_blur = 32;
    };
  };
}
