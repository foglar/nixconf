# Home Manager Configuration

This flake now includes home-manager support using flake-parts.

## Structure

The home-manager configuration is organized in the `modules/homeModules/` directory:

- `base/`: Base home-manager configuration
- `features/`: Reusable feature modules (git, shell, etc.)
- `users/`: Per-user configurations

## Usage

### Standalone Home Manager Configuration

To use home-manager as a standalone configuration:

```bash
# Build and activate the configuration
nix run github:nix-community/home-manager -- switch --flake .#yurii

# Or if you have home-manager installed:
home-manager switch --flake .#yurii
```

### Integrated with NixOS

To integrate home-manager into your NixOS configuration, import the `home-manager-integration` module:

```nix
{
  imports = [
    self.nixosModules.home-manager-integration
  ];

  home-manager.users.yourusername = {
    imports = [
      self.homeModules.base
      self.homeModules.git
      self.homeModules.shell
    ];
    
    # Additional per-user configuration
    programs.git = {
      enable = true;
      userName = "Your Name";
      userEmail = "your.email@example.com";
    };
  };
}
```

## Creating New Modules

To create a new home-manager module:

1. Create a new `.nix` file in `modules/homeModules/features/`
2. Follow the pattern:

```nix
{self, ...}: {
  flake.homeModules.mymodule = {
    lib,
    config,
    pkgs,
    ...
  }: {
    # Your home-manager configuration here
  };
}
```

3. The module will be automatically imported by `import-tree`

## Example Configurations

### Example 1: Basic User Configuration

```nix
# modules/homeModules/users/myuser.nix
{
  inputs,
  self,
  ...
}: {
  flake.homeConfigurations.myuser = inputs.home-manager.lib.homeManagerConfiguration {
    pkgs = inputs.nixpkgs.legacyPackages.x86_64-linux;
    
    modules = [
      self.homeModules.base
      self.homeModules.git
      self.homeModules.shell
      
      {
        home.username = "myuser";
        home.homeDirectory = "/home/myuser";
      }
    ];
  };
}
```

### Example 2: NixOS Integration

```nix
# In your NixOS configuration
{
  imports = [
    self.nixosModules.home-manager-integration
  ];

  home-manager.users.${config.preferences.user.name} = {
    imports = [
      self.homeModules.base
    ];
  };
}
```

## Relationship with hjem

This flake currently uses `hjem` for some user configuration management. Home-manager and hjem can coexist:

- **hjem**: Currently used for some system-level user configurations
- **home-manager**: Can be used for per-user dotfiles and program configurations

You can gradually migrate from hjem to home-manager or keep both depending on your needs.

## Available Modules

Current home-manager modules:

- `homeModules.base`: Base configuration with essential settings
- `homeModules.git`: Git configuration example
- `homeModules.shell`: Shell configuration example
- `homeModules.development`: Development tools and environment setup example

You can extend this by creating new modules in `modules/homeModules/features/`.

## Quick Start

### Check Available Outputs

To see all available home-manager configurations:
```bash
nix flake show
```

Look for the `homeConfigurations` section to see available user configurations.

### For Standalone Use

1. Edit `modules/homeModules/users/yurii.nix` (or create your own user file)
2. Customize the modules and configuration
3. Run: `nix run github:nix-community/home-manager -- switch --flake .#yurii`

### For NixOS Integration

1. In your NixOS configuration file (e.g., `modules/nixosModules/hosts/main/configuration.nix`):
   ```nix
   imports = [
     self.nixosModules.home-manager-integration
   ];

   home-manager.users.${config.preferences.user.name} = {
     imports = [
       self.homeModules.base
     ];
   };
   ```

2. Rebuild your NixOS system: `sudo nixos-rebuild switch --flake .#main`
