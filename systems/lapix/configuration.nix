# This is your system's configuration file.
# Use this to configure your system environment (it replaces /etc/nixos/configuration.nix)

{ inputs, lib, config, pkgs, ... }: {
  # You can import other NixOS modules here
  imports = [
    inputs.hardware.nixosModules.lenovo-thinkpad-x1-6th-gen

    #./common/optional/greetd.nix

    ./wireguard/default.nix
     
    # settings required to boot
    ./boot.nix

    ./hardware-configuration.nix
  ];

  nixpkgs = {
    overlays = [
    ];
    config = {
      allowUnfree = true;
    };
  };

  nix = {
    # This will add each flake input as a registry
    # To make nix3 commands consistent with your flake
    registry = lib.mapAttrs (_: value: { flake = value; }) inputs;

    # This will additionally add your inputs to the system's legacy channels
    # Making legacy nix commands consistent as well, awesome!
    nixPath = lib.mapAttrsToList (key: value: "${key}=${value.to.path}") config.nix.registry;

    settings = {
      # Enable flakes and new 'nix' command
      experimental-features = "nix-command flakes";
      # Deduplicate and optimize nix store
      auto-optimise-store = true;
    };
  };

  time.timeZone = "Europe/Berlin";
  i18n.defaultLocale = "en_US.UTF-8";

  fonts = {
    enableDefaultFonts = true;

    fonts = with pkgs; [
      hack-font
      noto-fonts-emoji
    ];
  };

  services.xserver.enable = true;

  # Enable the GNOME Desktop Environment.
  services.xserver.displayManager.gdm.enable = true;
  services.xserver.desktopManager.gnome.enable = true;

  # Configure keymap in X11
  services.xserver.layout = "us";
  # touchpad
  services.xserver.libinput.enable = true;
  
  # Fingerprint reader
  #services.fprintd.enable = true;

  # Quick start the service. no wait
  #systemd.services.fprintd = {
  #  wantedBy = [ "multi-user.target" ];
  #  serviceConfig.Type = "simple";
  #};
  services.logind.lidSwitch = "suspend-then-hibernate";

  #security.pam.services.<name>.fprintAuth

  environment.systemPackages = with pkgs; [
    vim # Do not forget to add an editor to edit configuration.nix! The Nano editor is also installed by default.
    wget
    curl
    git
    trashy
  ];

  # ~~~~~~~~~~~~~~~~~~~~~~~~~

  networking.hostName = "lapix";

  users.users = {
    knoff = {
      shell = pkgs.zsh;
      isNormalUser = true;
      openssh.authorizedKeys.keys = [
        # TODO: Add your SSH public key(s) here, if you plan on using SSH to connect
      ];
      extraGroups = [ "wheel" "networkmanager" "audio" ];
    };
  };

  # https://nixos.wiki/wiki/FAQ/When_do_I_update_stateVersion
  system.stateVersion = "22.11";
}
