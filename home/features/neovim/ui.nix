{ inputs, config, pkgs, lib, ... }:

let
  libContrib = inputs.nix-colors.lib-contrib { inherit pkgs;};
  colorscheme = libContrib.vimThemeFromScheme { scheme = config.colorscheme; };
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
        plugin = nvim-treesitter.withAllGrammars;
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
      
      # TODO config noice UI
      nvim-notify
      {
        plugin = noice-nvim;
        type = "lua";
        config = /*lua*/''
          require("noice").setup({
            lsp = {
              override = {
                ["vim.lsp.util.convert_input_to_markdown_lines"] = true,
                ["vim.lsp.util.stylize_markdown"] = true,
                ["cmp.entry.get_documentation"] = true, -- requires hrsh7th/nvim-cmp
              },
            },
            -- you can enable a preset for easier configuration
            presets = {
              bottom_search = true, -- use a classic bottom cmdline for search
              command_palette = false, -- position the cmdline and popupmenu together
              long_message_to_split = true, -- long messages will be sent to a split
              inc_rename = false, -- enables an input dialog for inc-rename.nvim
              lsp_doc_border = false, -- add a border to hover docs and signature help
            },

            views = {
              cmdline_popup = {
                position = {
                  row = "50%",
                  col = "50%",
                },
                size = {
                  width = 60,
                  height = "auto",
                },
              },
              popupmenu = {
                relative = "editor",
                position = {
                  row = 8,
                  col = "50%",
                },
                size = {
                  width = 60,
                  height = 10,
                },
                border = {
                  style = "rounded",
                  padding = { 0, 1 },
                },
                win_options = {
                  winhighlight = { Normal = "Normal", FloatBorder = "DiagnosticInfo" },
                },
              },
            },
          })
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
