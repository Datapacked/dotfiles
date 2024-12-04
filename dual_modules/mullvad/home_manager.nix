{
  pkgs,
  config,
  lib,
  ...
}: {
  home.packages = [
    pkgs.mullvad-vpn
  ];
}
