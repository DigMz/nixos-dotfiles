{ config, pkgs, ... }:

{
  programs.rofi = {
    enable = true;
    modes = [
      "drun"
      "run"
      "window"
      "ssh"
    ];
    extraConfig = {
      show-icons = true;
    };
  };

}
