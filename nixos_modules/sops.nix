{
  pkgs,
  inputs,
  lib,
  config,
  ...
}: {
  imports = [inputs.sops-nix.nixosModules.default];
  sops.age.sshKeyPaths = ["/etc/ssh/ssh_host_ed25519_key"];
  sops.age.keyFile = "/var/lib/sops-nix/key.txt";
  sops.age.generateKey = true;
  sops.secrets.password = {
    format = "binary";
    sopsFile = ../secrets/password.txt;
    neededForUsers = true;
  };
}
