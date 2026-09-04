{ config, pkgs, ... }:

{
  xdg.configHome = "${config.home.homeDirectory}/.config";

  xdg.mimeApps = {
    enable = true;
    defaultApplications = {
      "inode/directory" = "org.kde.dolphin.desktop";  # Dolphin for directories
      "text/html" = "zen-browser.desktop";
      "application/xhtml+xml" = "zen-browser.desktop";
      "x-scheme-handler/http" = "zen-browser.desktop";
      "x-scheme-handler/https" = "zen-browser.desktop";
    };
  };

  home.file.".local/share/desktop-directories/Applications.directory".text = ''
    [Desktop Entry]
    Type=Directory
    Name=Applications
  '';

  home.file.".config/menus/applications.menu".text = ''
    <!DOCTYPE Menu PUBLIC "-//freedesktop//DTD Desktop Menu 1.0//EN"
      "http://www.freedesktop.org/standards/menu-spec-1.0.dtd">
    <Menu>
      <Name>Applications</Name>
      <Directory>Applications.directory</Directory>

      <DefaultAppDirs/>
      <DefaultDirectoryDirs/>
      <DefaultMergeDirs/>

      <Include>
        <Category>Application</Category>
      </Include>
    </Menu>
  '';

  home.packages = with pkgs; [
    shared-mime-info
    desktop-file-utils
  ];
}
