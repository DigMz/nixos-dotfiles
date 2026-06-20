{ config, pkgs, ... }:

{
  programs.kitty = {
    enable = true;
    font = {
      name = "DejaVuSansMono";
      size = 14;
    };
  };
}
