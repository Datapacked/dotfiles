{
  config,
  pkgs,
  ...
}: {
  services.plex = {
    enable = true;
    openFirewall = true;
    package = pkgs.plex;
  };
}
