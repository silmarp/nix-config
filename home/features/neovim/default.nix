{ config, pkgs, ... }:

{
  imports = [
    ./lsp.nix
    ./notes.nix
    ./ui.nix
    ./util.nix
  ];

  programs.neovim = {
    enable = true;
    viAlias = true;
    defaultEditor = true;
    extraLuaConfig = /*lua*/''
      -- Variables
      local g = vim.g       -- Global variables
      local opt = vim.opt   -- Set options (global/buffer/windows-scoped)
      local augroup = vim.api.nvim_create_augroup   -- Create/get autocommand group
      local autocmd = vim.api.nvim_create_autocmd   -- Create autocommand

      -- General
      opt.mouse = 'a'                       -- Enable mouse support
      opt.swapfile = false                  -- Don't use swapfile
      opt.completeopt = 'menuone,noinsert,noselect'  -- Autocomplete options

      -- Tabs, indent
      opt.smartindent = true      -- Autoindent new lines
      opt.expandtab = true        -- Use spaces instead of tabs
      opt.shiftwidth = 4          -- Shift 4 spaces when tab
      opt.tabstop = 4             -- 1 tab == 4 spaces
      augroup('setIndent', { clear = true }) -- set indentation to 2 in certain filetypes
      autocmd('Filetype', {
        group = 'setIndent',
        pattern = { 'xml', 'html', 'xhtml', 'css', 'scss', 'javascript', 'typescript','yaml', 'lua', 'nix', 'vue',},
        command = 'setlocal shiftwidth=2 tabstop=2'
      })

      -- Custom filetypes
      vim.filetype.add({
        pattern = {
          ['docker-compose%.yml'] = 'yaml.docker-compose',
          ['docker-compose%.yaml'] = 'yaml.docker-compose',
          ['compose%.yml'] = 'yaml.docker-compose',
          ['compose%.yaml'] = 'yaml.docker-compose',
        },
      })

      -- Memory, CPU
      opt.hidden = true           -- Enable background buffers
      opt.history = 100           -- Remember N lines in history
      -- opt.lazyredraw = true       -- Faster scrolling | disabled problems with noice
      opt.synmaxcol = 240         -- Max column for syntax highlight
      opt.updatetime = 700        -- ms to wait for trigger an event

      -- Shortcuts
      vim.g.mapleader = ' '

      local options = { noremap = true, silent = true }

      vim.api.nvim_set_keymap('n', '<leader>bp', ':bprevious<CR>', options)
      vim.api.nvim_set_keymap('n', '<leader>bn', ':bnext<CR>', options)

      -- Relative movement on linebreak
      vim.api.nvim_set_keymap("", 'k', 'gk', options)
      vim.api.nvim_set_keymap("", 'j', 'gj', options)
    '';
  };
}
