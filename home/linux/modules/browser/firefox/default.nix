{
  inputs,
  pkgs,
  lib,
  config,
  username,
  ...
}: let
  profiles = import ./profiles.nix {inherit inputs pkgs lib config username;};

  package =
    pkgs.firefox;
in {
  imports = [
  ];

  programs.firefox = {
    enable = true;

    inherit package;

    nativeMessagingHosts = [pkgs.gnome-browser-connector];

    policies = import ./policies.nix {inherit pkgs lib config inputs;};

    inherit profiles;
  };
}
