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
        vim.api.nvim_set_keymap('n', '<leader>id', ":put =strftime('[[%d-%m-%Y_%T]]')<CR>", options)
      '';
    }
  ];
}
