{
  config,
  inputs,
  pkgs,
  ...
}:

{
  programs.obsidian = {
    enable = true;

    vaults = {
       CSCI-4334-OSCS = {
        enable = true;
        settings = {};
      };
    };
  };
}
