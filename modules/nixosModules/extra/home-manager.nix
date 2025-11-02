{inputs, self, ...}: {
  # This module integrates home-manager into NixOS configurations
  # It allows you to manage user configurations directly within your NixOS configuration
  
  flake.nixosModules.home-manager-integration = {
    config,
    pkgs,
    ...
  }: {
    imports = [
      inputs.home-manager.nixosModules.home-manager
    ];

    home-manager = {
      # Use the system's nixpkgs instead of home-manager's
      useGlobalPkgs = true;
      
      # Install packages to /etc/profiles instead of ~/.nix-profile
      useUserPackages = true;
      
      # Pass extra arguments to home-manager modules
      extraSpecialArgs = {
        inherit inputs self;
      };
      
      # Example user configuration
      # Uncomment and customize as needed:
      # users.${config.preferences.user.name} = {
      #   imports = [
      #     self.homeModules.base
      #   ];
      # };
    };
  };
}
