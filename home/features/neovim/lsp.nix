{ pkgs, ... }: {
  programs.neovim = { 
    plugins = with pkgs.vimPlugins; [
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
          local servers = { 'pyright', 'clangd', 'html', 'cssls', 'jsonls', 'nil_ls', 'texlab', 'rust_analyzer', 'sqlls', 'eslint', }

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
              ['<C-y>'] = cmp.mapping.confirm {
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
    ];

    # LSP Packages
    extraPackages = with pkgs;[
      nil
      nodePackages.pyright
      rust-analyzer
      
      # CSSLS ESlint html jsonls
      nodePackages.vscode-langservers-extracted
    ];
  };
}
