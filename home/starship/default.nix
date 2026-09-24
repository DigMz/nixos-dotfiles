{ config, pkgs, ... }:

{
  programs.starship = {
    enable = true;
    settings = {
      "$schema" = "https://starship.rs/config-schema.json";
  
      format = "[🭨](color_grey)$os$username[](bg:color_cyan fg:color_grey)$directory[](fg:color_cyan bg:color_faded_blue)$git_branch$git_status[](fg:color_faded_blue bg:color_dark_blue)$c$cpp$rust$golang$nodejs$bun$php$java$kotlin$haskell$python[](fg:color_dark_blue bg:color_bg3)$docker_context$conda$pixi$time[ ](fg:color_bg3)$line_break$character";
  
      palette = "tokyo-night";
  
      palettes.tokyo-night = {
        color_fg0 = "#fbf1c7";
        color_bg1 = "#3c3836";
        color_bg3 = "#1d1220";
        color_blue = "#458588";
        color_aqua = "#689d6a";
        color_green = "#98971a";
        color_orange = "#d65d0e";
        color_purple = "#b16286";
        color_red = "#cc241d";
        color_yellow = "#d79921";
        color_grey = "#a3aed2";
        color_cyan = "#769ff0";
        color_faded_blue = "#394260";
        color_dark_blue = "#212736";
      };
  
      os = {
        disabled = false;
        style = "bg:color_grey fg:color_dark_blue";
  
        symbols = {
          Windows = "󰍲 ";
          Ubuntu = "󰕈 ";
          SUSE = " ";
          Raspbian = "󰐿 ";
          Mint = "󰣭 ";
          Macos = "󰀵 ";
          Manjaro = " ";
          Linux = "󰌽 ";
          Gentoo = "󰣨 ";
          Fedora = "󰣛 ";
          Alpine = " ";
          Amazon = " ";
          Android = " ";
          AOSC = " ";
          Arch = "󰣇 ";
          Artix = "󰣇 ";
          EndeavourOS = " ";
          CentOS = " ";
          Debian = "󰣚 ";
          Redhat = "󱄛 ";
          RedHatEnterprise = "󱄛 ";
          Pop = " ";
          NixOS = " ";
        };
      };
  
      username = {
        show_always = true;
        style_user = "bg:color_grey fg:color_fg0";
        style_root = "bg:color_grey fg:color_fg0";
        format = "[ $user ]($style)";
      };
  
      directory = {
        style = "fg:color_fg0 bg:color_cyan";
        format = "[ $path ]($style)";
        truncation_length = 3;
        truncation_symbol = "…/";
  
        substitutions = {
          Documents = "󰈙 ";
          Downloads = " ";
          Music = "󰝚 ";
          Pictures = " ";
          Developer = "󰲋 ";
          Projects = " ";
        };
      };
  
      git_branch = {
        symbol = " ";
        style = "bg:color_faded_blue";
        format = "[[ $symbol $branch ](fg:color_fg0 bg:color_faded_blue)]($style)";
      };
  
      git_status = {
        style = "bg:color_faded_blue";
        format = "[[($all_status$ahead_behind )](fg:color_fg0 bg:color_faded_blue)]($style)";
      };
  
      nodejs = {
        symbol = "";
        style = "bg:color_blue";
        format = "[[ $symbol( $version) ](fg:color_fg0 bg:color_blue)]($style)";
      };
  
      bun = {
        symbol = "";
        style = "bg:color_blue";
        format = "[[ $symbol( $version) ](fg:color_fg0 bg:color_blue)]($style)";
      };
  
      c = {
        symbol = " ";
        style = "bg:color_blue";
        format = "[[ $symbol( $version) ](fg:color_fg0 bg:color_blue)]($style)";
      };
  
      cpp = {
        symbol = " ";
        style = "bg:color_blue";
        format = "[[ $symbol( $version) ](fg:color_fg0 bg:color_blue)]($style)";
      };
  
      rust = {
        symbol = "";
        style = "bg:color_blue";
        format = "[[ $symbol( $version) ](fg:color_fg0 bg:color_blue)]($style)";
      };
  
      golang = {
        symbol = "";
        style = "bg:color_blue";
        format = "[[ $symbol( $version) ](fg:color_fg0 bg:color_blue)]($style)";
      };
  
      php = {
        symbol = "";
        style = "bg:color_blue";
        format = "[[ $symbol( $version) ](fg:color_fg0 bg:color_blue)]($style)";
      };
  
      java = {
        symbol = "";
        style = "bg:color_blue";
        format = "[[ $symbol( $version) ](fg:color_fg0 bg:color_blue)]($style)";
      };
  
      kotlin = {
        symbol = "";
        style = "bg:color_blue";
        format = "[[ $symbol( $version) ](fg:color_fg0 bg:color_blue)]($style)";
      };
  
      haskell = {
        symbol = "";
        style = "bg:color_blue";
        format = "[[ $symbol( $version) ](fg:color_fg0 bg:color_blue)]($style)";
      };
  
      python = {
        symbol = "";
        style = "bg:color_blue";
        format = "[[ $symbol( $version) ](fg:color_fg0 bg:color_blue)]($style)";
      };
  
      docker_context = {
        symbol = "";
        style = "bg:color_bg3";
        format = "[[ $symbol( $context) ](fg:#83a598 bg:color_bg3)]($style)";
      };
  
      conda = {
        style = "bg:color_bg3";
        format = "[[ $symbol( $environment) ](fg:#83a598 bg:color_bg3)]($style)";
      };
  
      pixi = {
        style = "bg:color_bg3";
        format = "[[ $symbol( $version)( $environment) ](fg:color_fg0 bg:color_bg3)]($style)";
      };
  
      time = {
        disabled = true;
        time_format = "%R";
        style = "bg:color_bg1";
        format = "[[  $time ](fg:color_fg0 bg:color_bg1)]($style)";
      };
  
      line_break.disabled = false;
  
      character = {
        disabled = false;
        success_symbol = "[❭](bold fg:color_green)";
        error_symbol = "[❭](bold fg:color_red)";
        vimcmd_symbol = "[❭](bold fg:color_green)";
        vimcmd_replace_one_symbol = "[❭](bold fg:color_purple)";
        vimcmd_replace_symbol = "[❭](bold fg:color_purple)";
        vimcmd_visual_symbol = "[❭](bold fg:color_cyan)";
      };
    };
  };

  home.packages = with pkgs; [
    blesh
  ];
  programs.bash = {
    enable = true;
    bashrcExtra = ''
      [[ $- == *i* ]] && source -- "$(blesh-share)"/ble.sh --attach=none
    '';
    initExtra = pkgs.lib.mkOrder 2000 ''
      [[ ! ''${BLE_VERSION-} ]] || ble-attach
    '';
  };

  xdg.configFile."blesh" = {
    source = ./blesh;
    recursive = true;
  };
}
