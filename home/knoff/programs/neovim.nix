{ pkgs, ... }:
{
  programs.neovim = {
    enable = true;
    vimAlias = true;
    viAlias = true;
    extraConfig =
      ''
        set autoindent
        set expandtab
        set tabstop=2
        set shiftwidth=2
        set undofile
      '';
    plugins = with pkgs.vimPlugins; [
      direnv-vim # For .direnv + nixshell
      yankring
      vim-nix
      nvim-treesitter
      nvim-cmp
      fzf-vim
      fzfWrapper
      haskell-vim
      vim-lua
      rust-vim

      nvim-cmp

      vim-markdown
      vim-json
      neoformat
      #vim-lsp
      #nvim-lspconfig
    ];
  };
}
