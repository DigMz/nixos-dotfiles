{ config, pkgs, ... }:

{
  home.file.".local/share/applications/zen-browser.desktop".text = ''
    [Desktop Entry]
    Type=Application
    Name=Zen Browser
    Comment=A privacy-focused web browser
    Exec=zen %u
    Icon=zen
    Categories=Network;WebBrowser;
    MimeType=text/html;application/xhtml+xml;application/x-www-browser;x-scheme-handler/http;x-scheme-handler/https;
    StartupNotify=true
  '';
}
