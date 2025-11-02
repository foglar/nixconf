# Example: How to integrate home-manager into your NixOS configuration
#
# This file demonstrates different ways to use home-manager with this flake.
# You can copy and adapt these examples to your needs.

{
  inputs,
  self,
  ...
}: {
  # Example 1: Standalone home-manager configuration for multiple systems
  # Uncomment and customize as needed
  
  # flake.homeConfigurations = {
  #   # Configuration for x86_64-linux
  #   "user@hostname" = inputs.home-manager.lib.homeManagerConfiguration {
  #     pkgs = inputs.nixpkgs.legacyPackages.x86_64-linux;
  #     
  #     modules = [
  #       self.homeModules.base
  #       self.homeModules.git
  #       self.homeModules.shell
  #       self.homeModules.development
  #       
  #       {
  #         home.username = "user";
  #         home.homeDirectory = "/home/user";
  #         
  #         programs.git = {
  #           enable = true;
  #           userName = "Your Name";
  #           userEmail = "your.email@example.com";
  #         };
  #       }
  #     ];
  #   };
  #   
  #   # Configuration for aarch64-linux (e.g., Raspberry Pi)
  #   "user@pi" = inputs.home-manager.lib.homeManagerConfiguration {
  #     pkgs = inputs.nixpkgs.legacyPackages.aarch64-linux;
  #     
  #     modules = [
  #       self.homeModules.base
  #       # ... add your modules
  #     ];
  #   };
  # };
  
  # Example 2: Integrate home-manager into NixOS configuration
  # Add this to your NixOS host configuration:
  #
  # imports = [
  #   self.nixosModules.home-manager-integration
  # ];
  #
  # home-manager.users.${config.preferences.user.name} = {
  #   imports = [
  #     self.homeModules.base
  #     self.homeModules.git
  #     self.homeModules.shell
  #   ];
  #   
  #   programs.git = {
  #     enable = true;
  #     userName = "Your Name";
  #     userEmail = "your.email@example.com";
  #   };
  # };
}
