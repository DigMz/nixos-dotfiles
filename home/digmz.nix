{
  config,
  inputs,
  pkgs,
  unstable,
  ...
}:

{
  imports = [
    ./hypr
    ./kitty
    ./wayle
    ./rofi
    ./lazyvim
  ];

  home = {
    stateVersion = "26.05";

    sessionVariables = {
      EDITOR = "nvim";
      BROWSER = "zen";
    };

    packages =
      with pkgs;
      [
        nixfmt
        statix
        discord
      ]
      ++ (with unstable; [
        tuxedo
      ])
      ++ [
        inputs.zen-browser.packages.${pkgs.system}.default
      ];
  };
}
