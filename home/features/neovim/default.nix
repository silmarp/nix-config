{ config, pkgs, lib, ... }:


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
    ./vimwiki.nix
    ./tree.nix
  ];
  home.sessionVariables.EDITOR = "nvim";

  programs.neovim = {
    enable = true;
    viAlias = true;
    defaultEditor = true;

    extraConfig = ''
lua << EOF
-----------------------------------------------------------
-- General Neovim settings and configuration
-----------------------------------------------------------

local g = vim.g       -- Global variables
local opt = vim.opt   -- Set options (global/buffer/windows-scoped)

-----------------------------------------------------------
-- General
-----------------------------------------------------------
opt.mouse = 'a'                       -- Enable mouse support
opt.clipboard = 'unnamedplus'         -- Copy/paste to system clipboard
opt.swapfile = false                  -- Don't use swapfile
opt.completeopt = 'menuone,noinsert,noselect'  -- Autocomplete options

-----------------------------------------------------------
-- Neovim UI
-----------------------------------------------------------
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

-----------------------------------------------------------
-- Tabs, indent
-----------------------------------------------------------
opt.expandtab = true        -- Use spaces instead of tabs
opt.shiftwidth = 4          -- Shift 4 spaces when tab
opt.tabstop = 4             -- 1 tab == 4 spaces
opt.smartindent = true      -- Autoindent new lines

-----------------------------------------------------------
-- Memory, CPU
-----------------------------------------------------------
opt.hidden = true           -- Enable background buffers
opt.history = 100           -- Remember N lines in history
opt.lazyredraw = true       -- Faster scrolling
opt.synmaxcol = 240         -- Max column for syntax highlight
opt.updatetime = 700        -- ms to wait for trigger an event

-----------------------------------------------------------
-- Colorscheme
-----------------------------------------------------------
vim.cmd([[ colorscheme slate ]])
vim.cmd([[ highlight Normal guibg=none ]])

-----------------------------------------------------------
-- Neovim shortcuts
-----------------------------------------------------------
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

-- Clear search highlighting with <leader> and c
vim.api.nvim_set_keymap('n', '<leader>c', ':nohl<CR>', options)

-- Toggle auto-indenting for code paste
vim.api.nvim_set_keymap('n', '<F2>', ':set invpaste paste?<CR>', options)
vim.opt.pastetoggle = '<F2>'

-- Move around splits using Leader + {h,j,k,l}
vim.api.nvim_set_keymap('n', '<leader>h', '<C-w>h', options)
vim.api.nvim_set_keymap('n', '<leader>j', '<C-w>j', options)
vim.api.nvim_set_keymap('n', '<leader>k', '<C-w>k', options)
vim.api.nvim_set_keymap('n', '<leader>l', '<C-w>l', options)

-- Fast saving with <leader> and s
vim.api.nvim_set_keymap('n', '<leader>w', ':wall<CR>', options)

-- Close all windows and exit from Neovim with <leader> and q
vim.api.nvim_set_keymap('n', '<leader>qa', ':qa!<CR>', options)
vim.api.nvim_set_keymap('n', '<leader>q', ':q<CR>', options)

-----------------------------------------------------------
-- Neovim autocommands
-----------------------------------------------------------
local augroup = vim.api.nvim_create_augroup   -- Create/get autocommand group
local autocmd = vim.api.nvim_create_autocmd   -- Create autocommand

-- Set indentation to 2 spaces
augroup('setIndent', { clear = true })
autocmd('Filetype', {
  group = 'setIndent',
  pattern = { 'xml', 'html', 'xhtml', 'css', 'scss', 'javascript', 'typescript',
    'yaml', 'lua', 'nix', 'vue',
  },
  command = 'setlocal shiftwidth=2 tabstop=2'
})

-- Set spellcheck
augroup('spell', { clear = true })
autocmd('Filetype', {
  group = 'spell',
  pattern = { 'markdown', 'tex'},
  command = 'set spell spelllang=pt,en'
})
EOF
      '';

      plugins = with pkgs.vimPlugins; [
        vim-table-mode
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
      ];
    };
    /*telescope dependencie*/
    home.packages = [ pkgs.ripgrep ];
  home.file."${config.xdg.configHome}/nvim/spell/pt.utf-8.spl".source = nvim-spell-pt-utf8-dictionary;
  home.file."${config.xdg.configHome}/nvim/spell/pt.latin1.spl".source = nvim-spell-pt-latin1-dictionary;
}
