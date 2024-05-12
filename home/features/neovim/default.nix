{ config, pkgs, ... }:


let
  nvim-spell-pt-utf8-dictionary = builtins.fetchurl {
    url = "http://ftp.vim.org/vim/runtime/spell/pt.utf-8.spl";
    sha256 = "sha256:0fxnd9fvvxawmwas9yh47rakk65k7jjav1ikzcy7h6wmnq0c2pry";
  };

  nvim-spell-pt-latin1-dictionary = builtins.fetchurl {
    url = "http://ftp.vim.org/vim/runtime/spell/pt.latin1.spl";
    sha256 = "sha256:1046a4v595g30p1gnrhkddqdqscbvxs9dj9yd078jk226likc71w";
  };
in
{
  imports = [
    ./lsp.nix
    ./notes.nix
    ./tree.nix
    ./ui.nix
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
      opt.clipboard = 'unnamedplus'         -- Copy/paste to system clipboard
      opt.swapfile = false                  -- Don't use swapfile
      opt.completeopt = 'menuone,noinsert,noselect'  -- Autocomplete options

      -- Tabs, indent
      opt.expandtab = true        -- Use spaces instead of tabs
      opt.shiftwidth = 4          -- Shift 4 spaces when tab
      opt.tabstop = 4             -- 1 tab == 4 spaces
      opt.smartindent = true      -- Autoindent new lines
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

      -- Disable arrow keys
      vim.api.nvim_set_keymap("", '<up>', '<nop>', options)
      vim.api.nvim_set_keymap("", '<down>', '<nop>', options)
      vim.api.nvim_set_keymap("", '<left>', '<nop>', options)
      vim.api.nvim_set_keymap("", '<right>', '<nop>', options)

      --Relative movement
      vim.api.nvim_set_keymap("", 'k', 'gk', options)
      vim.api.nvim_set_keymap("", 'j', 'gj', options)

      -- Toggle auto-indenting for code paste
      vim.api.nvim_set_keymap('n', '<F2>', ':set invpaste paste?<CR>', options)

      -- Set spellcheck
      augroup('spell', { clear = true })
      autocmd('Filetype', {
        group = 'spell',
        pattern = { 'markdown', 'tex'},
        command = 'set spell spelllang=pt,en'
      })
    '';

    plugins = with pkgs.vimPlugins; [
      vim-table-mode
      {
        plugin = nvim-surround;
        type = "lua";
        config = /*lua*/ ''
          require("nvim-surround").setup()
        '';
      }
      {
				plugin = nvim-autopairs;
				type = "lua";
				config = /*lua*/''
					require("nvim-autopairs").setup {}
				'';
			}
    ];
  };
  /*telescope dependencie*/
  home.file."${config.xdg.configHome}/nvim/spell/pt.utf-8.spl".source = nvim-spell-pt-utf8-dictionary;
  home.file."${config.xdg.configHome}/nvim/spell/pt.latin1.spl".source = nvim-spell-pt-latin1-dictionary;
}
