def nix-clean () {
  nix-env --delete-generations old
  nix-store --gc
  nix-channel --update
  nix-env -u --always
  for link in /nix/var/nix/gcroots/auto/*
  do
    rm $(readlink "$link")
  done
  nix-collect-garbage -d
}