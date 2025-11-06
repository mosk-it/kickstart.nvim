-- You can add your own plugins here or in other files in this directory!
--  I promise not to create any merge conflicts in this directory :)
--
-- See the kickstart.nvim README for more information

vim.opt.swapfile = false
vim.opt.foldlevel = 99
vim.opt.foldlevelstart = 99

return {
  -- {
  --   "3rd/image.nvim",
  --   build = false, -- so that it doesn't build the rock https://github.com/3rd/image.nvim/issues/91#issuecomment-2453430239
  --   opts = {
  --     processor = "magick_cli",
  --   }
  -- },
  {
    'L3MON4D3/LuaSnip',
    opts = {
      history = true,
      updateevents = 'TextChanged,TextChangedI',
    },
    config = function(_, opts)
      local ls  = require('luasnip')
      local s   = ls.snippet
      local t   = ls.text_node
      local i   = ls.insert_node

      ls.config.set_config(opts)

      -- org-specific snippet
      ls.add_snippets('org', {
        s('src', {
          t('#+BEGIN_SRC '), i(1, 'lang'), t({ '', '' }),
          i(2, 'code'),
          t({ '', '#+END_SRC' }),
        }),
      })
    end,
  },

  {
    'nvim-orgmode/orgmode',
    event = 'VeryLazy',
    ft = { 'org' },
    mappings = {
      global = {
        cycle = false,
        org_cycle = false,
      },
    },
    config = function()
      -- Setup orgmode
      require('orgmode').setup {
        org_agenda_files = '~/org/**/*',
        org_default_notes_file = '~/org/todo.org',
        mappings = {
          org = {
            org_cycle = false,
            org_global_cycle = false,
          },
        },

        -- org_cycle = false,
        -- global = {
        --   org_cycle = false,
        --   cycle = false,
        -- }
      }

      vim.api.nvim_create_autocmd('FileType', {
        pattern = 'org',
        callback = function()
          vim.keymap.set('i', '<S-CR>', '<cmd>lua require("orgmode").action("org_mappings.meta_return")<CR>', {
            silent = true,
            buffer = true,
          })
        end,
      })

      -- NOTE: If you are using nvim-treesitter with ~ensure_installed = "all"~ option
      -- add ~org~ to ignore_install
      -- require('nvim-treesitter.configs').setup({
      --   ensure_installed = 'all',
      --   ignore_install = { 'org' },
      -- })
    end,
  },
  {
    'simonmclean/triptych.nvim',
    event = 'VeryLazy',
    dependencies = {
      'nvim-lua/plenary.nvim', -- required
      'nvim-tree/nvim-web-devicons', -- optional for icons
      -- 'antosha417/nvim-lsp-file-operations', -- optional LSP integration
    },
    opts = {}, -- config options here
    keys = {
      { '<leader>-', ':Triptych<CR>' },
    },
  },
  {
    { 'christoomey/vim-tmux-navigator' },
  },
  {
    'kdheepak/lazygit.nvim',
    lazy = true,
    cmd = {
      'LazyGit',
      'LazyGitConfig',
      'LazyGitCurrentFile',
      'LazyGitFilter',
      'LazyGitFilterCurrentFile',
    },
    -- optional for floating window border decoration
    dependencies = {
      -- 'nvim-lua/plenary.nvim',
    },
    -- setting the keybinding for LazyGit with 'keys' is recommended in
    -- order to load the plugin when the command is run for the first time
    keys = {
      { '<leader>gg', '<cmd>LazyGit<cr>', desc = 'LazyGit' },
    },
  },
  {
    'lumbric/suda.vim',
    config = function()
      vim.keymap.set('n', '<leader>e', '<cmd>NvimTreeToggle<cr>', { silent = true, desc = 'NvimTreeToggle' })
    end,
  },
  {
    'smoka7/multicursors.nvim',
    event = 'VeryLazy',
    dependencies = {
      'nvimtools/hydra.nvim',
    },
    opts = {},
    cmd = { 'MCstart', 'MCvisual', 'MCclear', 'MCpattern', 'MCvisualPattern', 'MCunderCursor' },
    keys = {
      {
        mode = { 'v', 'n' },
        '<Leader>m',
        '<cmd>MCstart<cr>',
        desc = 'Create a selection for selected text or word under the cursor',
      },
    },
  },
  {
    "kevinhwang91/nvim-ufo",
    dependencies = "kevinhwang91/promise-async",
    event = "BufRead",
    config = function()
      vim.o.foldcolumn = '0' -- '0' is not bad
      vim.o.foldlevel = 99
      vim.o.foldlevelstart = 99
      vim.o.foldenable = true

      vim.cmd([[
        hi Folded guibg=#424242
      ]])

      require("ufo").setup({
        enable_get_fold_virt_text = false,
        provider_selector = function(bufnr, filetype, buftype)
          return {'treesitter', 'indent'}
        end
      })
    end
  },
  {
    'chentoast/marks.nvim',
    event = 'VeryLazy',
    config = function()
      require('marks').setup {
        refresh_interval = 12500,
      }
    end,
  },

  { 'tpope/vim-fugitive' },
    fold_virt_text_handler = handler
}
