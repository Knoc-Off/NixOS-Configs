{ inputs, lib, config, pkgs, ... }: {
  imports = [

    ./wireguard/default.nix
    ./configuration.nix

  ];

}
