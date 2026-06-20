{ config, pkgs, ... }:

{
  programs.kitty = {
    enable = true;
    font = {
      size = 16;
    };
  };
}
