{self, ...}: {
  flake.homeModules.shell = {
    lib,
    config,
    pkgs,
    ...
  }: {
    # Example shell configuration module
    # This demonstrates how to configure shell programs with home-manager
    
    programs.bash = {
      enable = lib.mkDefault false;
      # Add bash configuration here if needed
    };
    
    programs.zsh = {
      enable = lib.mkDefault false;
      # Add zsh configuration here if needed
    };
    
    programs.fish = {
      enable = lib.mkDefault false;
      # Add fish configuration here if needed
    };
    
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
