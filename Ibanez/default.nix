{
  inputs,
  pkgs,
  config,
  hostname,
  username,
  system,
  stateVersion,
  ...
}: {
  imports = [
    ./hardware-configuration.nix
    ../nixos_modules/boot.nix
    ../nixos_modules/gnome.nix
    ../nixos_modules/networking.nix
    ../nixos_modules/printing.nix
    ../nixos_modules/sound.nix
    ../home/linux
    ../nixos_modules/steam.nix
    ../nixos_modules/electron_wayland.nix
    ../dual_modules
    ../dual_modules/mullvad/nixos.nix
    ../nixos_modules/plex.nix
  ];

  nix = {
    package = pkgs.nixFlakes;
    extraOptions = "experimental-features = nix-command flakes";
    settings.allowed-users = ["@wheel"];
  };
  nixpkgs.config.allowUnfree = true;

  users.mutableUsers = false;

  users.users.root = {
    hashedPassword = "*";
  };

  users.users.${username} = {
    home = "/home/${username}";
    isNormalUser = true;
    extraGroups = ["networkManager" "wheel"];
    initialPassword = "Luke1noah2?";
  };

  environment.systemPackages = with pkgs; [
    neovim
    zsh
    wget
    tree
    p7zip
    kdePackages.ark
    peazip
    rar
    unrar
    obsidian
  ];

  dual_modules.modules = {
    mullvad = {
      enable = true;
      users = {
        "${username}".enable = true;
      };
    };
  };
  programs.zsh.enable = true;
  users.defaultUserShell = pkgs.zsh;
  environment.shells = with pkgs; [zsh];
}
