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
    ../nixos_modules/fonts.nix
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
    extraGroups = ["networkManager" "wheel" "tty" "dialout"];
    initialPassword = "evelyn"; # used to be "Luke1noah2?"
  };

  services.usbmuxd = {
    enable = true;
    package = pkgs.usbmuxd2;
  };

  environment.systemPackages = with pkgs; [
    libimobiledevice
    ifuse
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
    easyeffects
    openjdk
    jdk17
    jdk11
    jdk8
    ffmpeg_6-full
    libgcc
    llvmPackages.clangUseLLVM
  ];
  programs.zsh.enable = true;
  users.defaultUserShell = pkgs.zsh;
  environment.shells = with pkgs; [zsh];
}
