{self, ...}: {
  flake.homeModules.development = {
    lib,
    config,
    pkgs,
    ...
  }: {
    # Development tools and environment configuration
    # This is an example module showing how to set up a development environment
    
    home.packages = with pkgs; [
      # Version control
      # git is usually system-wide, but you can add it here too
      # git
      
      # Development utilities (examples - uncomment as needed)
      # ripgrep
      # fd
      # bat
      # eza
      # fzf
      # jq
      # yq
      
      # Language servers and tools (examples - uncomment as needed)
      # nil # Nix LSP
      # nixpkgs-fmt
      # alejandra
    ];
    
    # Example: Configure direnv for per-directory environments
    programs.direnv = {
      enable = lib.mkDefault false;
      nix-direnv.enable = lib.mkDefault false;
    };
    
    # Example: Configure git if not configured elsewhere
    # programs.git = {
    #   enable = true;
    #   # Add your git configuration here
    # };
  };
}
