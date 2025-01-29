{
  inputs,
  config,
  lib,
  username,
  stateVersion,
  system,
  ...
}: {
  imports = [
    inputs.home-manager.nixosModules.home-manager
  ];

  home-manager.backupFileExtension = "homemanagerbackup";

  home-manager.useGlobalPkgs = true;
  home-manager.useUserPackages = true;

  home-manager.extraSpecialArgs = {
    inherit username inputs;

    system_config = config;
  };

  home-manager.users.${username} = {pkgs, ...}: let
  in {
    imports = [
      ./modules/browser/firefox
      ./modules/gnome.nix
      ./modules/starship.nix
      ./modules/vscode.nix
      ./modules/zsh.nix
      ./modules/obs.nix
      ./modules/browser/brave/brave.nix
      ./modules/helix.nix
      ./modules/spicetify.nix
      ./modules/yazi.nix
      ./modules/zoxide.nix
      ./modules/zellij.nix
      ./modules/nushell.nix
      ./modules/signal.nix
      ./modules/alacritty.nix
      ./modules/ghostty.nix
      ./modules/lazygit.nix
      ./modules/defaultapps.nix
    ];

    home = {
      inherit username stateVersion;
      homeDirectory = "/home/${username}";

      packages = with pkgs; [
        discord
        neovim
        git
        vesktop
        bottles
        neofetch
        lutris
        bitwarden-desktop
        telegram-desktop
        localsend
        duckstation
        pcsx2
        logseq
        qbittorrent
        libreoffice
        discord-canary
        zotero
        osu-lazer-bin
        arduino
        arduino-cli
        tor-browser
        btop
        gimp
        blender
        hollywood
        glava
        insomnia
      ];
    };
  };
}
