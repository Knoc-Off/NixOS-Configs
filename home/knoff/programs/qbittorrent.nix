{pkgs, config, libs, ... }:
{

    home.packages = with pkgs; [
      qbittorent
    ];

}
