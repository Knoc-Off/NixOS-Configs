# This is your home-manager configuration file

{ inputs, lib, config, pkgs, ... }: {
  # You can import other home-manager modules here
  imports = [
    # If you want to use home-manager modules from other flakes (such as nix-colors):
    # inputs.nix-colors.homeManagerModule
    # You can also split up your configuration and import pieces of it here:

    ./programs/neovim.nix
    ./programs/zsh.nix
    ./programs/alacritty.nix
    ./programs/firefox.nix
    ./programs/ssh.nix
  ];

  nixpkgs = {
    overlays = [
    ];
    config = {
      allowUnfree = true;
      allowUnfreePredicate = (pkg: true);
    };
  };

  home = {
    username = "knoff";
    homeDirectory = "/home/knoff";
  };

  programs.neovim.enable = true;
  home.packages = with pkgs; [ 
    trilium-desktop 
    tealdeer
    element-desktop
    ];

  programs.direnv.enable = true;
  programs.direnv.nix-direnv.enable = true;

  # Enable home-manager and git
  programs.home-manager.enable = true;
  programs.git.enable = true;

  # Nicely reload system units when changing configs
  systemd.user.startServices = "sd-switch";

  # https://nixos.wiki/wiki/FAQ/When_do_I_update_stateVersion
  home.stateVersion = "22.11";
}
