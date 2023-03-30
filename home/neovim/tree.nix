{ pkgs, ... }: {
  programs.neovim.plugins = with pkgs.vimPlugins; [
   {
      plugin = nvim-web-devicons;
      type = "lua";
      config = /* lua */ ''
         require'nvim-web-devicons'.setup {
         -- your personnal icons can go here (to override)
         -- you can specify color or cterm_color instead of specifying both of them
         -- DevIcon will be appended to `name`
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
      plugin = nvim-tree-lua;
      type = "lua";
      config = /* lua */ ''
        -- examples for your init.lua

        -- disable netrw at the very start of your init.lua (strongly advised)

        vim.g.loaded_netrw = 1
        vim.g.loaded_netrwPlugin = 1

        -- set termguicolors to enable highlight groups
        vim.opt.termguicolors = true

        -- empty setup using defaults
        require("nvim-tree").setup()

        -- OR setup with some options
        require("nvim-tree").setup({
          sort_by = "case_sensitive",
          renderer = {
            group_empty = true,
          },
          filters = {
            dotfiles = true,
          },
        })
        local options = { noremap = true, silent = true }

        vim.api.nvim_set_keymap('n', '<leader>n', ':NvimTreeToggle<CR>', options)

      '';
    }
  ];
}
