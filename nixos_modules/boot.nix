{...}: {
  boot.loader.grub = {
    enable = true;
    useOSProber = true;
    device = "nodev";
    efiSupport = true;
  };
  boot.loader.efi = {
    canTouchEfiVariables = true;
    efiSysMountPoint = "/boot/efi";
  };
}
