{self, ...}: {
  flake.homeModules.git = {
    lib,
    config,
    ...
  }: {
    # This is an example home-manager module for git configuration
    # You can customize it according to your needs
    
    # Example: Add default git configuration
    programs.git = {
      # These are example defaults - customize as needed
      # userName = "Your Name";
      # userEmail = "your.email@example.com";
      
      extraConfig = {
        init.defaultBranch = lib.mkDefault "main";
        pull.rebase = lib.mkDefault true;
      };
    };
  };
}
