{self, ...}: {
  flake.homeModules.base = {
    lib,
    config,
    pkgs,
    ...
  }: {
    # Basic home-manager configuration options
    
    # Home Manager needs a bit of information about you and the paths it should manage
    home.username = lib.mkDefault "yurii";
    home.homeDirectory = lib.mkDefault "/home/${config.home.username}";

    # This value determines the Home Manager release that your configuration is
    # compatible with. This helps avoid breakage when a new Home Manager release
    # introduces backwards incompatible changes.
    #
    # You should not change this value, even if you update Home Manager. If you do
    # want to update the value, then make sure to first check the Home Manager
    # release notes.
    home.stateVersion = "24.05";

    # Let Home Manager install and manage itself.
    programs.home-manager.enable = true;
  };
}
