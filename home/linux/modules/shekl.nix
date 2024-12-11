{...}: {
  programs.nushell.shellAliases = {
    start-AA = "sudo systemctl start wg-quick-AirVPN-America.service";
    stop-AA = "sudo systemctl stop wg-quick-AirVPN-America.service";
    start-AP = "sudo systemctl start wg-quick-AirVPN-Phoenix.service";
    stop-AP = "sudo systemctl stop wg-quick-AirVPN-Phoenix.service";
    rb = "zsh -c \"nix fmt && find ~ -name '*.homemanagerbackup' -delete && nixos-rebuild switch --use-remote-sudo --flake .#default\"";
  };
}
