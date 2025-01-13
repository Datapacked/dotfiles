{
  pkgs,
  config,
  lib,
  inputs,
  ...
}: {
  programs.ghostty = {
    enable = true;
    settings = {
      background-opacity = 0.9;
      background-blur-radius = 20;
      window-decoration = true;
      window-padding-x = 0;
      window-padding-y = 5;
      background = "black";
      font-family = "JetBrainsMono Nerd Font Mono";
    };
    enableBashIntegration = true;
    enableZshIntegration = true;
  };
}
