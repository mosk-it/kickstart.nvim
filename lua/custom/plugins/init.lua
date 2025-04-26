-- You can add your own plugins here or in other files in this directory!
--  I promise not to create any merge conflicts in this directory :)
--
-- See the kickstart.nvim README for more information

return {
  {
    'nvim-orgmode/orgmode',
    event = 'VeryLazy',
    ft = { 'org' },
    config = function()
      -- Setup orgmode
      require('orgmode').setup {
        org_agenda_files = '~/org/**/*',
        org_default_notes_file = '~/org/todo.org',
      }

      -- NOTE: If you are using nvim-treesitter with ~ensure_installed = "all"~ option
      -- add ~org~ to ignore_install
      -- require('nvim-treesitter.configs').setup({
      --   ensure_installed = 'all',
      --   ignore_install = { 'org' },
      -- })
    end,
  },
  -- {
  --   'simonmclean/triptych.nvim',
  --   event = 'VeryLazy',
  --   dependencies = {
  --     'nvim-lua/plenary.nvim', -- required
  --     'nvim-tree/nvim-web-devicons', -- optional for icons
  --     -- 'antosha417/nvim-lsp-file-operations', -- optional LSP integration
  --   },
  --   opts = {}, -- config options here
  --   keys = {
  --     { '<leader>-', ':Triptych<CR>' },
  --   },
  -- },
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
  { 'kevinhwang91/rnvimr' },
  { 'kevinhwang91/nvim-ufo' },
}
