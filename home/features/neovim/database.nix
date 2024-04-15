{ pkgs, ...}:

{
  programs.neovim = { 
    plugins = with pkgs.vimPlugins; [
      vim-dadbod
      vim-dadbod-completion
      vim-dadbod-ui     
    ];
  };
}
