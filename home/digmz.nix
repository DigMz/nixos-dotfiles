{
  config,
  inputs,
  pkgs,
  unstable,
  ...
}:

{
  imports = [
    ./kitty
    ./hypr
    ./wayle
    ./rofi
    ./xdg
    ./zen-browser
    ./lazyvim
    ./quickshell
    ./starship
    ./obsidian
    ./libreoffice
  ];

  programs.bash = {
    enable = true;
    sessionVariables = {
      EDITOR = "nvim";
      BROWSER = "zen";
      # Fix for Qt/KDE on Wayland
      QT_QPA_PLATFORM = "wayland";
      QT_AUTO_SCREEN_SCALE_FACTOR = "1";
      # QT_QUICK_CONTROLS_STYLE = "Basic";
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

  dconf.settings = {
    "org/gnome/desktop/interface" = {
      color-scheme = "prefer-dark";
    };
  };

  gtk = {
    enable = true;
    theme = {
      name = "Adwaita-dark";
      package = pkgs.gnome-themes-extra;
    };
    iconTheme = {
      package = pkgs.kdePackages.breeze-icons;
      name = "breeze-dark";           # "breeze-dark" if you want the dark variant
    };
  };
  qt = {
    enable = true;
    platformTheme.name = "kde";
    style = {
      name = "breeze";
      package = pkgs.kdePackages.breeze;
    };
  };


  home = {
    stateVersion = "26.05";

    file.".local/share/color-schemes/BreezeDark.colors".source =
      "${pkgs.kdePackages.breeze}/share/color-schemes/BreezeDark.colors";
    file.".config/kdeglobals".text = 
      let
        breezeDark = builtins.readFile "${pkgs.kdePackages.breeze}/share/color-schemes/BreezeDark.colors";
      in
      breezeDark + ''

        [General]
        TerminalApplication=kitty
      '';

    packages =
      with pkgs;
      [
        kdePackages.breeze

        # Adding Dolphin with its dependencies
        kdePackages.qtsvg
        kdePackages.kio
        kdePackages.kio-fuse
        kdePackages.kio-extras
        kdePackages.dolphin

        kdePackages.ark
        kdePackages.kamoso
        ffmpeg
        kdePackages.kdenlive
        kdePackages.gwenview
        kdePackages.kcalc
        kdePackages.krdc

        nixfmt
        statix
        discord
        prismlauncher
        krita
        codex

        zoom-us
      ]
      ++ (with unstable; [
        tuxedo
      ])
      ++ [
        inputs.zen-browser.packages.${pkgs.system}.default
      ];
  };
}
