{ inputs, config, pkgs, lib, ... }:

let
  libContrib = inputs.nix-colors.lib-contrib { inherit pkgs;};
  colorscheme = libContrib.vimThemeFromScheme { scheme = config.colorscheme; };
  my-nvim-treesitter = pkgs.vimPlugins.nvim-treesitter.withAllGrammars.overrideAttrs (oldAttrs: {
    src = pkgs.fetchFromGitHub {
      inherit (oldAttrs.src) owner repo;
      rev = "49e71322db582147ce8f4df1853d9dab08da0826";
      hash = "sha256-i7/YKin/AuUgzKvGgAzNTEGXlrejtucJacFXh8t/uFs=";
    };
  });
in

{
  programs.neovim = {
    extraLuaConfig = /* lua */ ''
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

      vim.cmd("source ${colorscheme}/colors/nix-${config.colorscheme.slug}.vim")

    '';

    plugins = with pkgs.vimPlugins; [
      {
        plugin = my-nvim-treesitter;
        type = "lua";
        config = /* lua */ ''
          require('nvim-treesitter.configs').setup {
            highlight = {
              enable = true,
              additional_vim_regex_highlighting = false,
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
