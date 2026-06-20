{
  config,
  inputs,
  pkgs,
  ...
}:

{
  imports = [ inputs.lazyvim.homeManagerModules.default ];

  programs.lazyvim = {
    enable = true;

    extras = {
      lang =
        let
          langDefaults = {
            enable = true;
            installDependencies = true;
            installRuntimeDependencies = true;
          };
        in
        {
          nix = langDefaults;
          rust = langDefaults;
          clangd = langDefaults;
          cmake = langDefaults;
          python = langDefaults;
        };
      editor.telescope.enable = true;
      ui.alpha.enable = true;
    };
  };
}
