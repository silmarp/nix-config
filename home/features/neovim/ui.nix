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
      opt.splitright = true       -- Vertical split to the right
      opt.splitbelow = true       -- Horizontal split to the bottom
      opt.ignorecase = true       -- Ignore case letters when search
      opt.smartcase = true        -- Ignore lowercase for the whole pattern
      opt.linebreak = true        -- Wrap on word boundary
      opt.termguicolors = true    -- Enable 24-bit RGB colors
      opt.laststatus=3            -- Set global statusline
      opt.relativenumber = true   -- Relative number lines

      -- Folds
      opt.foldmethod = 'expr'   -- Enable folding (default 'foldmarker')
      opt.foldlevel=20
      opt.foldexpr="nvim_treesitter#foldexpr()" -- Set fold expr to treesitter
      vim.cmd("source ${colorscheme}/colors/nix-${config.colorscheme.slug}.vim")
    '';

    plugins = with pkgs.vimPlugins; [
    {
      plugin = nvim-web-devicons;
      type = "lua";
      config = /* lua */ ''
         require'nvim-web-devicons'.setup {

         override = {
           zsh = {
            icon = "",
            color = "#428850",
            cterm_color = "65",
            name = "Zsh"
           }
         };
         -- globally enable different highlight colors per icon (default to true)
         -- if set to false all icons will have the default icon's color
         color_icons = true;
         -- globally enable default icons (default to false)
         -- will get overriden by `get_icons` option
         default = true;
         -- globally enable "strict" selection of icons - icon will be looked up in
         -- different tables, first by filename, and if not found by extension; this
         -- prevents cases when file doesn't have any extension but still gets some icon
         -- because its name happened to match some extension (default to false)
         strict = true;
         -- same as `override` but specifically for overrides by filename
         -- takes effect when `strict` is true
         override_by_filename = {
          [".gitignore"] = {
            icon = "",
            color = "#f1502f",
            name = "Gitignore"
          }
         };
         -- same as `override` but specifically for overrides by extension
         -- takes effect when `strict` is true
         override_by_extension = {
          ["log"] = {
            icon = "",
            color = "#81e043",
            name = "Log"
          }
         };
        }
      '';
    }

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
      
      nvim-notify
      {
        plugin = noice-nvim;
        type = "lua";
        config = /*lua*/''
          vim.api.nvim_set_keymap('n', '<leader>nn', ':NoiceDismiss<CR>', options)
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
              bottom_search = false, -- use a classic bottom cmdline for search
              command_palette = false, -- position the cmdline and popupmenu together
              long_message_to_split = true, -- long messages will be sent to a split
              inc_rename = false, -- enables an input dialog for inc-rename.nvim
              lsp_doc_border = false, -- add a border to hover docs and signature help
            },
          })
        '';
      }
      {
        plugin = indent-blankline-nvim;
        type = "lua";
        config = /* lua */ ''
          require('ibl').setup{
            scope = { highlight = {"IndentBlankLine"} },
            indent = { highlight = {"IndentBlankLine"} },
          }
        '';
      }
      {
        plugin = telescope-nvim;
        type = "lua";
        config = /*lua*/ ''
          local builtin = require('telescope.builtin')
          vim.keymap.set('n', '<leader>tf', builtin.find_files, {})
          vim.keymap.set('n', '<leader>tg', builtin.live_grep, {})
          vim.keymap.set('n', '<leader>tb', builtin.buffers, {})
          vim.keymap.set('n', '<leader>th', builtin.help_tags, {})
        '';
      }
      {
        plugin = alpha-nvim;
        type = "lua";
        config = /*lua*/ ''
          local alpha = require("alpha")
          local dashboard = require("alpha.themes.dashboard")

          dashboard.section.header.val = {
                "⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⣀⣀⣤⣤⣤⣤⣀⡀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀",
                "⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⢀⣠⣴⣾⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣶⣤⡀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀",
                "⠀⠀⠀⠀⠀⠀⠀⠀⠀⢀⣴⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣷⡄⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀",
                "⠀⠀⠀⠀⠀⠀⠀⠀⣠⣾⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣄⠀⠀⠀⠀⠀⠀⠀⠀⠀",
                "⠀⠀⠀⠀⠀⠀⠀⢠⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⡆⠀⠀⠀⠀⠀⠀⠀⠀",
                "⠀⠀⠀⠀⠀⠀⢀⣾⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣧⠀⠀⠀⠀⠀⠀⠀⠀",
                "⠀⠀⠀⠀⠀⠀⢰⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⠀⠀⠀⠀⠀⠀⠀⠀",
                "⠀⠀⠀⠀⠀⠀⣸⣿⣿⣿⣿⣿⣿⣿⣿⠁⠈⣿⠾⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⡄⠀⠀⠀⠀⠀⠀⠀",
                "⠀⠀⠀⠀⠀⠀⢸⣿⣿⣿⣿⣿⣿⣿⣿⠀⠀⣿⠃⣿⣿⣿⣿⢿⣿⣿⣿⣿⣿⣿⣿⡿⣧⠀⠀⠀⠀⠀⠀⠀",
                "⠀⠀⠀⠀⠀⠀⠸⣿⣿⣿⣿⣿⣻⣿⣼⠤⣤⠼⠵⣿⠟⠻⢿⢾⡿⠧⢽⣿⣿⣿⣿⡇⠙⠀⠀⠀⠀⠀⠀⠀",
                "⠀⠀⠀⠀⠀⠀⠀⢿⣿⡟⣿⡏⢓⣟⣶⣶⣾⠗⠀⠀⠀⠄⠺⢿⣶⣶⡞⣿⣿⣿⡇⠀⠀⠀⠀⠀⠀⠀⠀⠀",
                "⠀⠀⠀⠀⠀⠀⠀⠘⣿⣿⣌⣇⠀⠈⠉⠉⠀⠀⢀⠠⠀⢀⠀⠈⠉⠉⠀⣿⣿⣿⠇⠀⠀⠀⠀⠀⠀⠀⠀⠀",
                "⠀⠀⠀⠀⠀⠀⠀⠰⠻⣿⣿⣿⣄⠀⠀⠐⠀⠀⠂⠀⠠⠀⢀⠠⠀⠀⢠⣿⣿⣿⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀",
                "⠀⠀⠀⠀⠀⠀⠀⠀⠀⠹⡿⢿⡿⢧⡀⠄⠀⠁⢀⣙⣀⡁⠀⠀⢀⡼⠛⣿⣿⡿⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀",
                "⠀⠀⠀⠀⠀⠀⠀⠀⠀⠈⠁⠀⠁⢰⣿⣶⣦⣄⣀⠀⠀⡀⣠⣼⣾⣷⠄⣿⣿⡇⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀",
                "⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⢠⠴⣾⣿⣿⣿⣿⣿⣶⣯⣷⣿⣿⣿⣿⣿⡗⣿⣿⡇⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀",
                "⠀⠀⠀⠀⠀⠀⠀⠀⣀⠔⣫⠦⣹⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⡷⣿⣿⡣⢄⠀⠀⠀⠀⠀⠀⠀⠀⠀",
                " ⠀⠀⠀⢀⡠⠒⠉⠀⠀⢹⡜⡥⣚⢿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⡙⣿⣿⠏⠀⠉⠢⢄⡀⠀⠀⠀⠀⠀",
                "⠀⠀⠀⠀⡸⠤⠤⢤⣀⣀⡸⢎⡵⣘⠮⣝⣿⣿⣿⣿⣿⣿⣿⣿⡿⢥⢛⣼⡏⠀⢀⣠⠴⠊⠙⢄⠀⠀⠀⠀",
          }
          dashboard.section.header.opts.hl = "Title"

          dashboard.section.buttons.val = {
              dashboard.button( "n", "󰈔 New file" , ":enew<CR>"),
              dashboard.button( "e", " Explore", ":NvimTreeToggle<CR>"),
              dashboard.button( "f", "󰍉 Find files", ":Telescope find_files<CR>"),
          }

          alpha.setup(dashboard.opts)
          vim.keymap.set("n", "<space>h", ":Alpha<CR>", { desc = "Open home dashboard" })
        '';
      }
    {
      plugin = bufferline-nvim;
      type = "lua";
      config =/*lua*/''
          require('bufferline').setup{}
        '';
    }
      {
        plugin = which-key-nvim;
        type = "lua";
      }
    ];
  };
    
  home.packages = [ pkgs.ripgrep ]; #TODO is this really necessary ?
}
