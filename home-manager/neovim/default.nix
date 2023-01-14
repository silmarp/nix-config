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
  home.sessionVariables.EDITOR = "nvim";

  programs.neovim = {
    enable = true;
    viAlias = true;

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
    'yaml', 'lua', 'nix',
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
          plugin = vimwiki;
          type = "lua";
          config = ''
            vim.g.vimwiki_list = {{path = '~/Documents/personal-management', syntax = 'markdown', ext = '.md'}}
          '';
        }
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
          plugin = nvim-lspconfig;
          type = "lua";
          config = /* lua */ ''
            -----------------------------------------------------------
            -- Neovim LSP configuration file
            -----------------------------------------------------------

            -- Plugin: nvim-lspconfig
            -- url: https://github.com/neovim/nvim-lspconfig

            -- For configuration see the Wiki: https://github.com/neovim/nvim-lspconfig/wiki
            -- Autocompletion settings of "nvim-cmp" are defined in plugins/nvim-cmp.lua

            local lsp_status_ok, lspconfig = pcall(require, 'lspconfig')
            if not lsp_status_ok then
              return
            end

            local cmp_status_ok, cmp_nvim_lsp = pcall(require, 'cmp_nvim_lsp')
            if not cmp_status_ok then
              return
            end

            -- Diagnostic options, see: `:help vim.diagnostic.config`
            vim.diagnostic.config({
              update_in_insert = true,
              float = {
                focusable = false,
                style = "minimal",
                border = "rounded",
                source = "always",
                header = "",
                prefix = "",
                },
            })

            -- Show line diagnostics automatically in hover window
            vim.cmd([[
              autocmd CursorHold,CursorHoldI * lua vim.diagnostic.open_float(nil, { focus = false })
            ]])

            -- Use an on_attach function to only map the following keys
            -- after the language server attaches to the current buffer
            local on_attach = function(client, bufnr)
              local function buf_set_keymap(...) vim.api.nvim_buf_set_keymap(bufnr, ...) end
              local function buf_set_option(...) vim.api.nvim_buf_set_option(bufnr, ...) end

              -- Enable completion triggered by <c-x><c-o>
              buf_set_option('omnifunc', 'v:lua.vim.lsp.omnifunc')

              -- Mappings.
              local opts = { noremap = true, silent = true }

              -- See `:help vim.lsp.*` for documentation on any of the below functions
              buf_set_keymap('n', 'gD', '<cmd>lua vim.lsp.buf.declaration()<CR>', opts)
              buf_set_keymap('n', 'gd', '<cmd>lua vim.lsp.buf.definition()<CR>', opts)
              buf_set_keymap('n', 'K', '<cmd>lua vim.lsp.buf.hover()<CR>', opts)
              buf_set_keymap('n', 'gi', '<cmd>lua vim.lsp.buf.implementation()<CR>', opts)
              buf_set_keymap('n', '<C-k>', '<cmd>lua vim.lsp.buf.signature_help()<CR>', opts)
              buf_set_keymap('n', '<space>wa', '<cmd>lua vim.lsp.buf.add_workspace_folder()<CR>', opts)
              buf_set_keymap('n', '<space>wr', '<cmd>lua vim.lsp.buf.remove_workspace_folder()<CR>', opts)
              buf_set_keymap('n', '<space>wl', '<cmd>lua print(vim.inspect(vim.lsp.buf.list_workspace_folders()))<CR>', opts)
              buf_set_keymap('n', '<space>D', '<cmd>lua vim.lsp.buf.type_definition()<CR>', opts)
              buf_set_keymap('n', '<space>rn', '<cmd>lua vim.lsp.buf.rename()<CR>', opts)
              buf_set_keymap('n', '<space>ca', '<cmd>lua vim.lsp.buf.code_action()<CR>', opts)
              buf_set_keymap('n', 'gr', '<cmd>lua vim.lsp.buf.references()<CR>', opts)
              buf_set_keymap('n', '<space>e', '<cmd>lua vim.lsp.diagnostic.show_line_diagnostics()<CR>', opts)
              buf_set_keymap('n', '[d', '<cmd>lua vim.lsp.diagnostic.goto_prev()<CR>', opts)
              buf_set_keymap('n', ']d', '<cmd>lua vim.lsp.diagnostic.goto_next()<CR>', opts)
              buf_set_keymap('n', '<space>q', '<cmd>lua vim.lsp.diagnostic.set_loclist()<CR>', opts)
              buf_set_keymap('n', '<space>f', '<cmd>lua vim.lsp.buf.formatting()<CR>', opts)
            end

            --[[

            Language servers setup:

            For language servers list see:
            https://github.com/neovim/nvim-lspconfig/blob/master/doc/server_configurations.md

            --]]

            -- Define `root_dir` when needed
            -- See: https://github.com/neovim/nvim-lspconfig/issues/320
            -- This is a workaround, maybe not work with some servers.
            local root_dir = function()
              return vim.fn.getcwd()
            end

            -- Use a loop to conveniently call 'setup' on multiple servers and
            -- map buffer local keybindings when the language server attaches.
            -- Add your language server below:
            local servers = { 'bashls', 'pyright', 'clangd', 'html', 'cssls', 'tsserver', 'rnix', 'texlab', 'rust_analyzer', 'sqls', }

            -- Call setup
            for _, lsp in ipairs(servers) do
              lspconfig[lsp].setup {
                on_attach = on_attach,
                root_dir = root_dir,
                flags = {
                  -- default in neovim 0.7+
                  debounce_text_changes = 150,
                }
              }
            end
          '';
        }
        # Completion
        cmp-nvim-lsp
        cmp-buffer
        cmp-path
        lspkind-nvim
        {
          plugin = nvim-cmp;
          type = "lua";
          config = /* lua */ ''
            -----------------------------------------------------------
            -- Autocomplete configuration file
            -----------------------------------------------------------

            -- Plugin: nvim-cmp
            -- url: https://github.com/hrsh7th/nvim-cmp


            local cmp_status_ok, cmp = pcall(require, 'cmp')
            if not cmp_status_ok then
              return
            end

            cmp.setup {
              -- Load snippet support
              formatting = { format = require('lspkind').cmp_format() },

            -- Completion settings
              completion = {
                --completeopt = 'menu,menuone,noselect'
                keyword_length = 2
              },

              -- Key mapping
              mapping = {
                ['<C-n>'] = cmp.mapping.select_next_item(),
                ['<C-p>'] = cmp.mapping.select_prev_item(),
                ['<C-d>'] = cmp.mapping.scroll_docs(-4),
                ['<C-f>'] = cmp.mapping.scroll_docs(4),
                ['<C-Space>'] = cmp.mapping.complete(),
                ['<C-e>'] = cmp.mapping.close(),
                ['<CR>'] = cmp.mapping.confirm {
                  behavior = cmp.ConfirmBehavior.Replace,
                  select = true,
                },
              },

              -- Load sources, see: https://github.com/topics/nvim-cmp
              sources = {
                { name = 'nvim_lsp' },
                { name = 'path' },
                { name = 'buffer', option = { get_bufnrs = vim.api.nvim_list_bufs } },
              },
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
  home.file."${config.xdg.configHome}/nvim/spell/pt.utf-8.spl".source = nvim-spell-pt-utf8-dictionary;
  home.file."${config.xdg.configHome}/nvim/spell/pt.latin1.spl".source = nvim-spell-pt-latin1-dictionary;
}
