{ pkgs, ... }:

{
  programs.neovim = {
    extraLuaConfig = ''

      local opt = vim.opt   -- Set options (global/buffer/windows-scoped)
      opt.number = true           -- Show line number
      opt.showmatch = true        -- Highlight matching parenthesis
      opt.foldmethod = 'marker'   -- Enable folding (default 'foldmarker')
      opt.splitright = true       -- Vertical split to the right
      opt.splitbelow = true       -- Horizontal split to the bottom
      opt.ignorecase = true       -- Ignore case letters when search
      opt.smartcase = true        -- Ignore lowercase for the whole pattern
      opt.linebreak = true        -- Wrap on word boundary
      opt.termguicolors = true    -- Enable 24-bit RGB colors
      opt.laststatus=3            -- Set global statusline
      opt.relativenumber = true   -- Relative number lines

      vim.cmd([[ colorscheme slate ]])
      vim.cmd([[ highlight Normal guibg=none ]])


    '';

    plugins = with pkgs.vimPlugins; [
      {
        plugin = nvim-treesitter.withAllGrammars;
        type = "lua";
        config = ''
          require('nvim-treesitter.configs').setup {
            highlight = {
              enable = true,
            }
          }
        '';
      }

      {
        plugin = nvim-colorizer-lua;
        type = "lua";
        config = /*lua*/''
          require 'colorizer'.setup()
        '';
      }

/*
      {
        plugin = which-key-nvim;
        type = "lua";
      }
*/
    ];
  };
}
