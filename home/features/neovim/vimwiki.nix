{ pkgs, config, ... }: {
  programs.neovim.plugins = with pkgs.vimPlugins; [
    {
      plugin = vimwiki;
      type = "lua";
      config = ''
        vim.g.vimwiki_list = {{path = '~/Documents/personal-management', syntax = 'markdown', ext = '.md'}}
        local autocmd = vim.api.nvim_create_autocmd 
        autocmd('BufEnter', {
          pattern = '*/personal-management/*',
          command = 'cd ~/Documents/personal-management'
        })

        -- Insert date-time link file
        local options = { noremap = true, silent = true }
        vim.api.nvim_set_keymap('n', '<leader>d', ":VimwikiToggleListItem<CR>", options)
      '';
    }

    {
      plugin = zk-nvim;
      type = "lua";
      config = /*lua*/ ''
      require("zk").setup({
        -- can be "telescope", "fzf" or "select" (`vim.ui.select`)
        -- it's recommended to use "telescope" or "fzf"
        picker = "telescope",
      
        lsp = {
          -- `config` is passed to `vim.lsp.start_client(config)`
          config = {
            cmd = { "zk", "lsp" },
            name = "zk",
            -- on_attach = ...
            -- etc, see `:h vim.lsp.start_client()`
          },
      
          -- automatically attach buffers in a zk notebook that match the given filetypes
          auto_attach = {
            enabled = true,
            filetypes = { "markdown" },
          },
        },
      })
      '';
    }
  ];
}
