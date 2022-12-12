{ pkgs, config, lib, ... }:
{
  boot.initrd.luks.devices = {
    root = {
      device = "/dev/disk/by-uuid/0e20547e-dcbe-44aa-ab8c-3ff8ec79e9b1";
      preLVM = true;
      allowDiscards = true;
    };
  };

  boot.kernelPackages = pkgs.linuxPackages_latest;
  boot.supportedFilesystems = [ "btrfs" ];
  hardware.enableAllFirmware = true;


  # Use the systemd-boot EFI boot loader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  networking.networkmanager.enable = true;  # Easiest to use and most distros use this by default.
}
