{
  pkgs,
  lib,
  config,
  flake_lib,
  ...
}:
flake_lib.modules.mkSimpleDualModule {
  inherit config;

  option_path = ["dual_modules" "modules" "mullvad"];
  description = "Enable Mullvad";

  nixos_imports = [./nixos.nix];
  home_manager_imports = [./home_manager.nix];
}
