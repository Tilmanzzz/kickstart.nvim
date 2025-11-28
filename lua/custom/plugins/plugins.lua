return {
  {
    'neovim/nvim-lspconfig',
    config = function()
      -- Only setup zls if vim.lsp.configs is available
      if not vim.lsp or not vim.lsp.configs then
        return
      end

      local configs = vim.lsp.configs

      -- Register zls if it isn’t already
      if not configs.zls then
        configs.zls = {
          default_config = {
            cmd = { 'zls' },
            filetypes = { 'zig' },
            root_dir = function(fname)
              return vim.fs.dirname(fname)
            end,
            settings = {},
          },
        }
      end

      -- Start zls for zig files
      vim.api.nvim_create_autocmd('FileType', {
        pattern = 'zig',
        callback = function()
          vim.lsp.start { name = 'zls' }
        end,
      })
    end,
  },

  -- Optional: autocomplete with nvim-cmp
  {
    'hrsh7th/nvim-cmp',
    dependencies = { 'hrsh7th/cmp-nvim-lsp' },
    config = function()
      local cmp = require 'cmp'
      cmp.setup {
        mapping = cmp.mapping.preset.insert {
          ['<C-Space>'] = cmp.mapping.complete(),
          ['<CR>'] = cmp.mapping.confirm { select = true },
        },
        sources = { { name = 'nvim_lsp' } },
      }
    end,
  },
}
