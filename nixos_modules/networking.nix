{lib, ...}: {
  networking.hostName = "nixos"; # Define your hostname.
  networking.wireless.enable = true; # Enables wireless support via wpa_supplicant.

  # Configure network proxy if necessary
  # networking.proxy.default = "http://user:password@proxy:port/";
  # networking.proxy.noProxy = "127.0.0.1,localhost,internal.domain";

  # Enable networking
  networking.networkmanager = {
    enable = lib.mkForce false;
    wifi.backend = "iwd";
  }; # FINALLY FIXED THE WIFI ISSUES **AGAIN (hopefully)** :3 - 12/3/2024 11:36 AM - 12/3/2024 12:11 PM

  
     networking.wireless.iwd = {
    enable = true;
    settings.General.EnableNetworkConfiguration = true;
    settings.Network.NameResolvingService = "resolvconf";
  };
  networking.wireless.iwd.settings = {
    IPv6 = {
      Enabled = true;
    };
    Settings = {
      AutoConnect = true;
    };
  };
 
}
