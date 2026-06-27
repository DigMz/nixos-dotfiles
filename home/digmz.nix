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
    bashrcExtra = ''
      eval "$(direnv hook bash)"
    '';
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
