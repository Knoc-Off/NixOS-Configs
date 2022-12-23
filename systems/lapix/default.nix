{ inputs, ... }: {
  imports = [

    ./wireguard/default.nix
    ./configuration.nix

  ];

}
