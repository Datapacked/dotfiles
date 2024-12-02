{
  inputs,
  pkgs,
  config,
  ...
}: let
  extensions = inputs.nix-vscode-extensions.extensions.${pkgs.system};
in {
  programs.vscode = {
    enable = true;
    package = pkgs.vscodium;
    extensions = with pkgs.vscode-extensions; [
      vscodevim.vim
      rust-lang.rust-analyzer
      bbenoist.nix
      haskell.haskell
      svelte.svelte-vscode
      golang.go
      extensions.vscode-marketplace.reditorsupport.r
      eamodio.gitlens
      inputs.vscoq.packages.${pkgs.system}.vscoq-client.extension
    ];
    userSettings = {
      "workbench.colorTheme" = "Default Dark Modern";
      "window.titleBarStyle" = "custom";
      "window.customTitleBarVisibility" = "windowed";
      "window.enableMenuBarMnemonics" = false;
    };
  };

  # See https://github.com/microsoft/vscode/issues/192590
  programs.zsh.envExtra = ''
    alias code='codium --disable-features=WaylandFractionalScaleV1'
  '';
}
