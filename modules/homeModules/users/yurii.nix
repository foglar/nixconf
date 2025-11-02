{
  inputs,
  self,
  ...
}: {
  flake.homeConfigurations.yurii = inputs.home-manager.lib.homeManagerConfiguration {
    pkgs = inputs.nixpkgs.legacyPackages.x86_64-linux;
    
    modules = [
      self.homeModules.base
      
      # Add additional home-manager modules here
      # For example:
      # self.homeModules.features.git
      # self.homeModules.features.shell
      
      # Or inline configuration:
      {
        home.packages = [];
        
        # Example programs configuration
        # programs.git = {
        #   enable = true;
        #   userName = "Your Name";
        #   userEmail = "your.email@example.com";
        # };
      }
    ];
  };
}
