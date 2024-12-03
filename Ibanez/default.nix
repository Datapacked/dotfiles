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
    (inputs.lix-module.nixosModules.default)
    ./hardware-configuration.nix
    ../nixos_modules/boot.nix
    ../nixos_modules/gnome.nix
    ../nixos_modules/networking.nix
    ../nixos_modules/printing.nix
    ../nixos_modules/sound.nix
    ../home/linux
    ../nixos_modules/steam.nix
    ../nixos_modules/electron_wayland.nix
    ../nixos_modules/doas.nix
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
    initialPassword = "evelyn"; # used to be "Luke1noah2?"
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
    wireguard-tools
    amberol
    proxychains-ng
    vscodium
  ];
  programs.zsh.enable = true;
  users.defaultUserShell = pkgs.zsh;
  environment.shells = with pkgs; [zsh];
}
