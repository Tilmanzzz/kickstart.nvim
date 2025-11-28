return {
  {
    'ziglang/zig.vim',
    ft = 'zig',
  },
  {
    'neovim/nvim-lspconfig',
    ft = 'zig',
    opts = {
      on_attach = function(client, bufnr)
        local map = function(keys, func, desc)
          vim.keymap.set('n', keys, func, { buffer = bufnr, desc = desc })
        end

        map('gd', vim.lsp.buf.definition, 'Goto Definition')
        map('gr', require('telescope.builtin').lsp_references, 'References')
        map('K', vim.lsp.buf.hover, 'Hover Info')
        map('<leader>rn', vim.lsp.buf.rename, 'Rename Symbol')
      end,
      settings = {
        zig = {
          build = 'release-safe',
        },
      },
    },
    config = function(_, opts)
      vim.lsp.config(opts)
    end,
  },
}
