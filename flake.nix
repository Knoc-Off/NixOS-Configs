{
  description = "lowfat config";

  inputs = {
    # Nixpkgs
    nixpkgs.url = "github:nixos/nixpkgs/nixos-22.11";
    # unstable.url = "github:nixos/nixpkgs/nixos-unstable";

    firefox-addons = {
      url = "gitlab:rycee/nur-expressions?dir=pkgs/firefox-addons";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    #nur.url = github:nix-community/NUR;

    sops-nix.url = github:Mic92/sops-nix;


    # Nixified software I use
    hyprland.url = "github:hyprwm/hyprland/v0.17.0beta";
    hyprwm-contrib.url = "github:hyprwm/contrib";

    # Home manager
    home-manager.url = "github:nix-community/home-manager";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";

    # TODO: Add any other flake you might need
    hardware.url = "github:nixos/nixos-hardware";

    # Shameless plug: looking for a way to nixify your themes and make
    # everything match nicely? Try nix-colors!
    nix-colors.url = "github:misterio77/nix-colors";
  };

  newVariable = {
    a = true;
  };

  outputs = { self, nixpkgs, nur, sops-nix, home-manager, nixos-hardware, ... }@inputs: {
    # Available through 'nixos-rebuild --flake .#your-hostname'
    nixosConfigurations = {
      knoff = nixpkgs.lib.nixosSystem {
        specialArgs = { inherit inputs; };
        modules = 
	[ 
          ./systems/lapix # lenovo thinkpad x1 6th gen
          #nixos-hardware.nixosModules.lenovo-thinkpad-x1-6th-gen
        ];
      };
    };

    # Available through 'home-manager --flake .#your-username@your-hostname'
    homeConfigurations = {
      "knoff@lapix" = home-manager.lib.homeManagerConfiguration {
        pkgs = nixpkgs.legacyPackages.x86_64-linux;
        extraSpecialArgs = { inherit inputs; };
        modules = [ ./home/knoff/home.nix ]; # default?
      };
    };
  };
}
