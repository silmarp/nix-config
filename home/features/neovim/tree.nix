{ pkgs, ... }: {
  programs.neovim.plugins = with pkgs.vimPlugins; [
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
