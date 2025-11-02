{inputs, ...}: {
  imports = [
    inputs.home-manager.flakeModules.default
  ];

  perSystem = {
    pkgs,
    system,
    ...
  }: {
    # Per-system home-manager packages can be defined here if needed
  };
}
