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

You can extend this by creating new modules in `modules/homeModules/features/`.
