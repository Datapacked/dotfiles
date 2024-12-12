{...}: {
  programs.nushell.shellAliases = rec {
    start-AA = "sudo systemctl start wg-quick-AirVPN-America.service";
    stop-AA = "sudo systemctl stop wg-quick-AirVPN-America.service";
    start-AP = "sudo systemctl start wg-quick-AirVPN-Phoenix.service";
    stop-AP = "sudo systemctl stop wg-quick-AirVPN-Phoenix.service";
    rb = "zsh -c \"nix fmt && find ~ -name '*.homemanagerbackup' -delete && nixos-rebuild switch --use-remote-sudo --flake .#default\"";
    rbp = "proxychains4 -q -f proxychains.conf ${rb}";
    sshocks = "ssh root@172.20.10.1 -N -D 1080";
  };
}
