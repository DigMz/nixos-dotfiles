{ config, pkgs, ... }:

{
  home.packages = with pkgs; [ 
    kdePackages.qtsvg
    kdePackages.qtimageformats
    kdePackages.qtmultimedia
    kdePackages.qt5compat
  ];

  programs.quickshell = {
    enable = true;
  };

  xdg.configFile."quickshell" = {
    source = ./config;
    recursive = true;
  };
}
