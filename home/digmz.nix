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
    ./hypr
    ./wayle
    ./rofi
    ./xdg
    ./lazyvim
  ];

  # wallpaper-launcher only works with both hyprland and rofi
  xdg = {
    desktopEntries = {
      wallpaper_launcher = {
        exec = "/home/digmz/dotfiles/nixos/home/rofi/wallpaper_launcher/wallpaper-launcher.sh";
        genericName = "wallpaper-launcher";
        name = "Wallpaper Launcher";
        terminal = false;
      };

    };
  };

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

  home.pointerCursor = {
    package = pkgs.kdePackages.breeze;
    name = "breeze_cursors";   # or "Breeze_Light" / "breeze-dark"
    size = 24;
    gtk.enable = true;
    x11.enable = true;         # also needed so XWayland apps pick it up
  };

  gtk.iconTheme = {
    package = pkgs.kdePackages.breeze-icons;
    name = "breeze";           # "breeze-dark" if you want the dark variant
  };

  home = {
    stateVersion = "26.05";

    packages =
      with pkgs;
      [
        # Adding Dolphin with its dependencies
        kdePackages.qtsvg
        kdePackages.kio
        kdePackages.kio-fuse
        kdePackages.kio-extras
        kdePackages.dolphin

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
