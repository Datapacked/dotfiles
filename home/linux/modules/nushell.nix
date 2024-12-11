{
  pkgs,
  lib,
  config,
  ...
}: {
  imports = [
    ./shekl.nix
  ];

  programs.nushell = {
    configFile.text = ''
      sleep 7ms
      $env.config = {show_banner: false}
    '';
    enable = true;
    environmentVariables = builtins.mapAttrs (name: value: builtins.toString value) config.home.sessionVariables;
  };
}
