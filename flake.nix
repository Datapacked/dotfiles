{
  description = "NixOS configuration flake";

  inputs = {
    vscoq = {
      url = github:coq-community/vscoq/53bc95c6e57504e11c0f785915f24b1b02707f9f;
    };
    firefox-addons = {
      url = gitlab:rycee/nur-expressions?dir=pkgs/firefox-addons;
    };
    nix-vscode-extensions = {
      url = github:nix-community/nix-vscode-extensions;
      inputs.nixpkgs.follows = "nixpkgs";
    };
    zsh-titles = {
      url = github:amyreese/zsh-titles;
      flake = false;
    };
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    nixpkgs-lts.url = "github:NixOS/nixpkgs";
    nixpkgs-23-11.url = "github:NixOS/nixpkgs/nixos-23.11";
    pre-commit-hooks-nix = {
      url = "github:cachix/pre-commit-hooks.nix";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    home-manager = {
      url = github:nix-community/home-manager;
      inputs.nixpkgs.follows = "nixpkgs";
    };
    helix = {
      url = github:helix-editor/helix;
      inputs.nixpkgs.follows = "nixpkgs";
    };
    spicetify-nix = {
      url = "github:Gerg-L/spicetify-nix";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = inputs @ {
    self,
    flake-parts,
    ...
  }: let
    stateVersion = "25.05";
  in
    flake-parts.lib.mkFlake {inherit inputs;} {
      imports = [
        inputs.pre-commit-hooks-nix.flakeModule
        ./lib
      ];

      flake = {config, ...}: {
        formatter.x86_64-linux = inputs.nixpkgs.legacyPackages.x86_64-linux.alejandra;

        nixosConfigurations = {
          default = let
            system = "x86_64-linux";
          in
            self.lib.systems.mkLinuxSystem "nixos" "evelyn" system stateVersion [] {};
        };
      };

      systems = ["x86_64-linux"];
    };
}
