{
  config,
  inputs,
  pkgs,
  unstable,
  ...
}:

{
  imports = [
    ./github-cli
    ./kitty
    ./wayle
    ./rofi
    ./lazyvim
  ];

  programs.bash = {
    enable = true;
    sessionVariables = {
      EDITOR = "nvim";
      BROWSER = "zen";
    };
  };

  programs.direnv = {
    enable = true;
    enableBashIntegration = true;
    nix-direnv.enable = true;
  };

  home = {
    stateVersion = "26.05";

    packages =
      with pkgs;
      [ nixfmt
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
