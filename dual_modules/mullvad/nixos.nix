{
  inputs,
  pkgs,
  lib,
  config,
  ...
}: let
  cfg = config.dual_modules.modules.mullvad;
in {
  services.mullvad-vpn = {
    enable = true;
    package = pkgs.mullvad-vpn;
  };

  networking.wireguard.enable = true;

  # From https://haseebmajid.dev/posts/2023-06-20-til-how-to-declaratively-setup-mullvad-with-nixos/
  systemd.services.mullvad-daemon.postStart = let
    mullvad = config.services.mullvad-vpn.package;
    mullvad-bin = "${mullvad}/bin/mullvad";
  in ''
    while ! ${mullvad-bin} status >/dev/null; do sleep 1; done
    ${mullvad-bin} auto-connect set on
    ${mullvad-bin} dns set default --block-ads --block-trackers --block-malware --block-gambling
    ${mullvad-bin} lockdown-mode set on
  '';
}
