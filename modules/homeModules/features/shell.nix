{self, ...}: {
  flake.homeModules.shell = {
    lib,
    config,
    pkgs,
    ...
  }: {
    # Example shell configuration module
    # This demonstrates how to configure shell programs with home-manager
    # Import this module and enable the shells you want to use
    
    # Example: uncomment to enable specific shells
    # programs.bash.enable = true;
    # programs.zsh.enable = true;
    # programs.fish.enable = true;
    
    # Example: Add common shell utilities to home packages
    home.packages = with pkgs; [
      # Add packages here, for example:
      # bat
      # eza
      # fd
      # ripgrep
    ];
  };
}
