# Integration Example for Existing NixOS Configuration

This example shows how to add home-manager to the existing `main` host configuration.

## Step 1: Update your host configuration

Edit `modules/nixosModules/hosts/main/configuration.nix` and add the home-manager integration:

```nix
{
  inputs,
  self,
  ...
}: {
  flake.nixosConfigurations.main = inputs.nixpkgs.lib.nixosSystem {
    modules = [
      self.nixosModules.hostMain
    ];
  };

  flake.nixosModules.hostMain = {pkgs, config, ...}: {
    imports = [
      self.nixosModules.base
      self.nixosModules.general
      self.nixosModules.desktop
      
      # ... existing imports ...
      
      # ADD THIS: Import home-manager integration
      self.nixosModules.home-manager-integration
    ];
    
    # ... existing configuration ...
    
    # ADD THIS: Configure home-manager for your user
    home-manager.users.${config.preferences.user.name} = {
      imports = [
        self.homeModules.base
        # Add more modules as needed:
        # self.homeModules.git
        # self.homeModules.shell
        # self.homeModules.development
      ];
      
      # Per-user home-manager configuration
      programs.git = {
        enable = true;
        userName = "Your Name";
        userEmail = "your.email@example.com";
      };
      
      # Add any other home-manager configuration here
    };
  };
}
```

## Step 2: Rebuild your system

```bash
sudo nixos-rebuild switch --flake .#main
```

## Alternative: Standalone Home Manager

If you prefer to use home-manager separately from NixOS:

### Create a user configuration

Create or edit `modules/homeModules/users/yourusername.nix`:

```nix
{
  inputs,
  self,
  ...
}: {
  flake.homeConfigurations.yourusername = inputs.home-manager.lib.homeManagerConfiguration {
    pkgs = inputs.nixpkgs.legacyPackages.x86_64-linux;
    
    modules = [
      self.homeModules.base
      self.homeModules.git
      self.homeModules.shell
      self.homeModules.development
      
      {
        home.username = "yourusername";
        home.homeDirectory = "/home/yourusername";
        
        programs.git = {
          enable = true;
          userName = "Your Name";
          userEmail = "your.email@example.com";
        };
      }
    ];
  };
}
```

### Activate the configuration

```bash
# If you don't have home-manager installed:
nix run github:nix-community/home-manager -- switch --flake .#yourusername

# If you have home-manager installed:
home-manager switch --flake .#yourusername
```

## Tips

1. **Start Simple**: Begin by just importing `self.homeModules.base`, then gradually add more modules.

2. **Mix with hjem**: The existing `hjem` configuration can coexist with home-manager. You might want to:
   - Use hjem for system-level dotfiles management
   - Use home-manager for user programs and configurations

3. **Module Organization**: Keep your home-manager modules organized:
   - `homeModules/base`: Essential settings
   - `homeModules/features`: Reusable feature modules
   - `homeModules/users`: Per-user complete configurations

4. **Debugging**: If something doesn't work:
   ```bash
   # Check flake outputs
   nix flake show
   
   # Build without switching to test
   nix build .#homeConfigurations.yourusername.activationPackage
   ```
