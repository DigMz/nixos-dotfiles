{ config, pkgs, ... }:

{
  home.packages = with pkgs; [ jq pywal16 ];

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
