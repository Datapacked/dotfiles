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
      rust-lang.rust-analyzer
      bbenoist.nix
      haskell.haskell
      svelte.svelte-vscode
      golang.go
      extensions.vscode-marketplace.reditorsupport.r
      eamodio.gitlens
      aaron-bond.better-comments
      inputs.vscoq.packages.${pkgs.system}.vscoq-client.extension
      thenuprojectcontributors.vscode-nushell-lang
    ];
    userSettings = {
      "workbench.colorTheme" = "Default Dark Modern";
      "window.titleBarStyle" = "custom";
      "window.customTitleBarVisibility" = "windowed";
      "window.enableMenuBarMnemonics" = false;
      # "http.proxy" = "socks5://127.0.0.1:1080/";
    };
  };
  programs.nushell.shellAliases = {
    code = "codium --disable-features=WaylandFractionalScaleV1";
  };
  # See https://github.com/microsoft/vscode/issues/192590
  programs.zsh.envExtra = ''
    alias code='codium --disable-features=WaylandFractionalScaleV1'
  '';
}
