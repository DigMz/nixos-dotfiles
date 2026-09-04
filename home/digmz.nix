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
      # Timezone fallback (also fix system config below)
      TZ = "US/Central";  # or your actual timezone
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
      name = "breeze-dark";
      package = pkgs.kdePackages.breeze;
    };
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

        # Adding Calender
        kdePackages.akonadi
        kdePackages.akonadi-calendar
        kdePackages.akonadi-contacts
        kdePackages.kdepim-runtime
        kdePackages.pimcommon
        kdePackages.merkuro

        kdePackages.ark
        kdePackages.kamoso
        ffmpeg
        kdePackages.kdenlive
        kdePackages.gwenview
        kdePackages.kdeconnect-kde
        kdePackages.partitionmanager
        kdePackages.kcalc
        kdePackages.krdc
        kdePackages.kclock

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
