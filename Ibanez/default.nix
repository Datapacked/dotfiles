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
    ../nixos_modules/doas.nix
    ../nixos_modules/wg-quick.nix
    ../nixos_modules/wg-quick-phoenix.nix
    ../nixos_modules/fonts.nix
    ../nixos_modules/wg-quick-NC.nix
    ../nixos_modules/xdg-portals.nix
    ../nixos_modules/hyprland.nix
    # ../nixos_modules/cosmic.nix
    ../nixos_modules/sops.nix
  ];

  nix = {
    package = pkgs.nixVersions.stable;
    extraOptions = "experimental-features = nix-command flakes";
    settings.allowed-users = ["@wheel"];
  };

  system = {inherit stateVersion;};
  nixpkgs.config.allowUnfree = true;

  nixpkgs.config.permittedInsecurePackages = [
    "electron-27.3.11"
  ];

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
    neovim
    libimobiledevice
    ifuse
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
    nushell
    proxychains-ng
    vscodium
    easyeffects
    openjdk
    jdk17
    jdk11
    jdk8
    ffmpeg_6-full
    speedtest
    # idk the gcc libs that i place here :3
    libgcc
    llvmPackages.clangUseLLVM
    llvmPackages.libcxxStdenv
    llvmPackages.libcxxClang
    libcxx
    glibc
    stdenv
    inputs.zen-browser.packages."${system}".default
    waybar
    dunst
    libnotify
    swww
    kitty
    rofi-wayland
    sops
  ];
  programs.zsh.enable = false;
  users.defaultUserShell = pkgs.nushell;
  environment.shells = with pkgs; [nushell];
  zramSwap.enable = true;
}
