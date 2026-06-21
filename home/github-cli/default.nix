{ config, pkgs, ... }:

{
  programs.gh = {
    enable = true;
    hosts = {
      user = "DigMz";
    };
  };
}
