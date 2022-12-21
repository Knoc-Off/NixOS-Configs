{ pkgs, ... }:
{
  home-manager.users.niko = { pkgs, ... }: {
    home.packages = with pkgs; [
      unstable.chroma # Required for colorize...
      imagemagick # Required for catomg
      thefuck # If you forget sudo or something
      qrencode
    ];

    programs.mcfly = {
      enable = true;
      enableZshIntegration = true;
      keyScheme = "vim";
    };

    programs.zsh = {
      enable = true;
      sessionVariables = {
        ZSH_COLORIZE_TOOL = "chroma";
      };
      oh-my-zsh.enable = true;
      oh-my-zsh.plugins = [
        "colorize"
        "extract"
        "fancy-ctrl-z"
        "fd"
        "mosh"
      ];
      shellAliases = {
        rm = ''echo "use trash-cli instead"'';
        remove = "rm";
        tmux = "TERM=screen-256color tmux";
      };
      initExtra = __readFile ../configs/zshrc.sh; 
    };
  };
}
