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
      local f = ls.function_node

      local function date()
        return os.date '%Y-%m-%d'
      end

      local function datetime()
        return os.date '%Y-%m-%d %H:%M'
      end

      ls.config.set_config(opts)

      -- org-specific snippet
      ls.add_snippets('org', {
        s('src', {
          t('#+BEGIN_SRC '), i(1, 'lang'), t({ '', '' }),
          i(2, 'code'),
          t({ '', '#+END_SRC' }),
        }),
      })
        ls.add_snippets('javascript', {
            s('cl', { t 'console.log(', i(1, '%s'), t ')' }),
        })

        ls.add_snippets('typescript', {
            s('cl', { t 'console.log(', i(1, '%s'), t ')' }),
        })

        markdown_snippets = {
          s('fm', {
            t '---',
            t { '', 'title: ' },
            i(1, 'Title'),
            t { '', 'date: ' },
            f(date),
            t { '', 'tags: [' },
            i(2, ''),
            t { ']', '', '---', '' },
            i(0),
          }),

          s('todo', {
            t '---',
            t { '', 'title: ' },
            i(1, 'Todo'),
            t { '', 'date: ' },
            f(date),
            t { '', 'tags: [todo]', '', '---', '', '- [ ] ' },
            i(2, 'task'),
            t { '', '' },
            i(0),
          }),


          s('tag', {
            t 'tags: [',
            i(1, ''),
            t ']',
          }),
          --
          s('link', {
            t '[',
            i(1, 'text'),
            t '](',
            i(2, 'url'),
            t ')',
          }),

          s('img', {
            t '![',
            i(1, 'alt'),
            t '](',
            i(2, 'path'),
            t ')',
          }),

          -- s('code', {
            --   t '```&#x27;,
            --   i(1, &#x27;lang&#x27;),
            --   t { &#x27;&#x27;, &#x27;&#x27; },
            --   i(2, &#x27;code&#x27;),
            --   t { &#x27;&#x27;, &#x27;```' },
            -- }),

            s('table', {
              t '| ',
              i(1, 'Header'),
              t ' | ',
              i(2, 'Header'),
              t ' |',
              t { '', '| --- | --- |', '| ' },
              i(3, 'cell'),
              t ' | ',
              i(4, 'cell'),
              t ' |',
            }),

            -- s('chb', {
              --   t '- [ ] ',
              --   i(1, 'task'),
              -- }),
              --
              -- s('ch', {
                --   t '- [ ] ',
                --   i(1, 'task'),
                --   t { '', '- [ ] ' },
                --   i(2, 'task'),
                --   t { '', '- [ ] ' },
                --   i(3, 'task'),
                -- }),

                s('quote', {
                  t '> ',
                  i(1, 'quote'),
                }),

                s('front', {
                  t '---',
                  t { '', 'title: ' },
                  i(1),
                  t { '', 'date: ' },
                  f(date),
                  t { '', 'tags: [' },
                  i(2),
                  t { ']', 'status: ' },
                  i(3, 'active'),
                  t { '', '---', '' },
                  i(0),
                }),


                s('datet', {
                  f(function() return {os.date("%Y-%m-%dT%H:%M")} end, {}),
                }),

                s('date', {
                  f(function() return {os.date("%Y-%m-%d")} end, {}),
                }),

                s('#remindd', {
                  t('#'),
                  i(1, 'remind'),
                  t(':'),
                  f(function() return {os.date("%Y-%m-%dT%H:%M")} end, {}),
                  i(2),
                }),

                s('#remindp', {
                  t('#'),
                  i(1, 'remind'),
                  t(':-PT60M'),
                  i(2),
                }),

                s('#duet', {
                  t('#'),
                  i(1, 'due'),
                  t(':'),
                  f(function() return {os.date("%Y-%m-%dT%H:%M")} end, {}),
                  i(2),
                }),


                s('#due', {
                  t('#'),
                  i(1, 'due'),
                  t('/'),
                  f(function() return {os.date("%Y-%m-%d")} end, {}),
                  i(2),
                }),


              }

              ls.add_snippets('todo', markdown_snippets)
              ls.add_snippets('text', markdown_snippets)
              ls.add_snippets('txt', markdown_snippets)
              ls.add_snippets('markdown', markdown_snippets)



    end,
  },
  {
    { 'christoomey/vim-tmux-navigator' },
  },
  {
    'lumbric/suda.vim',
    config = function()
      vim.keymap.set('n', '<leader>e', '<cmd>NvimTreeToggle<cr>', { silent = true, desc = 'NvimTreeToggle' })
    end,
  },
  {
      "kevinhwang91/nvim-ufo",
      dependencies = "kevinhwang91/promise-async",
      event = "BufRead",
      config = function()
          vim.o.foldcolumn = '0'
          vim.o.foldlevel = 99
          vim.o.foldlevelstart = 99
          vim.o.foldenable = true

          vim.cmd([[ hi Folded guibg=#3d3626 ]])


          require("ufo").setup({
              enable_get_fold_virt_text = true,
              fold_virt_text_handler = function(virtText, lnum, endLnum, width, truncate)
                  local newVirtText = {}
                  local suffix = (' +--- folded: %d '):format(endLnum - lnum)
                  local sufWidth = vim.fn.strdisplaywidth(suffix)
                  local targetWidth = width - sufWidth
                  local curWidth = 0
                  for _, chunk in ipairs(virtText) do
                      local chunkText = chunk[1]
                      local chunkWidth = vim.fn.strdisplaywidth(chunkText)
                      if targetWidth > curWidth + chunkWidth then
                          table.insert(newVirtText, chunk)
                      else
                          chunkText = truncate(chunkText, targetWidth - curWidth)
                          table.insert(newVirtText, {chunkText, chunk[2]})
                          chunkWidth = vim.fn.strdisplaywidth(chunkText)
                          if curWidth + chunkWidth < targetWidth then
                              suffix = suffix .. (' '):rep(targetWidth - curWidth - chunkWidth)
                          end
                          break
                      end
                      curWidth = curWidth + chunkWidth
                  end
                  table.insert(newVirtText, {suffix, 'Comment'})
                  return newVirtText
              end,

          })

          -- auto-close level +3
            vim.api.nvim_create_autocmd("BufReadPost", {
              pattern = "*",
              callback = function()
                vim.defer_fn(function()
                  require("ufo").closeFoldsWith(3)
                end, 500)
              end,
            })

          vim.keymap.set('n', 'zF', function()
              local level = vim.v.count
              if level == 0 then level = 2 end  -- default when no prefix given
              require('ufo').closeFoldsWith(level)
          end, { desc = 'Close folds at level (default 2)' })


          vim.keymap.set('n', 'zn', function()
              require('ufo.action').goNextClosedFold()
          end, { desc = 'Go next closed fold' })

          vim.keymap.set('n', 'zp', function()
              require('ufo.action').goPreviousClosedFold()
          end, { desc = 'Go prev closed fold' })


      end,
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

  { -- Collection of various small independent plugins/modules
    'echasnovski/mini.nvim',
    config = function()
      -- tpope/vim-surround like settings
      require('mini.surround').setup {
        mappings = {
          add = 'ys',
          delete = 'ds',
          find = '',
          find_left = '',
          highlight = '',
          replace = 'cs',
          update_n_lines = '',

          -- Add this only if you don't want to use extended mappings
          suffix_last = '',
          suffix_next = '',
        },
        search_method = 'cover_or_next',
      }



      require('mini.notify').setup({
        window = {
          config = function()
            local has_statusline = vim.o.laststatus > 0
            local pad = vim.o.cmdheight + (has_statusline and 1 or 0)
            return { anchor = 'SE', col = vim.o.columns, row = vim.o.lines - pad }
          end,
        },
      })

      vim.keymap.del('x', 'ys')
      vim.keymap.set('x', 'S', [[:<C-u>lua MiniSurround.add('visual')<CR>]], { silent = true })

      -- require('mini.icons').setup()
      require('mini.tabline').setup {
        -- Whether to show file icons (requires 'mini.icons')
        show_icons = true,

        -- Function which formats the tab label
        format = function(buf_id, label)
          local suffix = vim.bo[buf_id].modified and '*' or ' '
          return string.gsub(MiniTabline.default_format(buf_id, label), '%s+$', '') .. suffix
        end,

        -- Where to show tabpage section in case of multiple vim tabpages.
        -- One of 'left', 'right', 'none'.
        tabpage_section = 'left',
      }

      vim.api.nvim_set_hl(0, 'MiniTablineCurrent', { bold = true, fg = 'black', bg = 'orange' })
      vim.api.nvim_set_hl(0, 'MiniTablineModifiedCurrent', { fg = 'black', bg = 'orange', italic = true })
      vim.api.nvim_set_hl(0, 'MiniTablineModifiedVisible', { italic = true })

      -- Simple and easy statusline.
      --  You could remove this setup call if you don't like it,
      --  and try some other statusline plugin
      local statusline = require 'mini.statusline'
      -- set use_icons to true if you have a Nerd Font
      statusline.setup { use_icons = vim.g.have_nerd_font }

      -- You can configure sections in the statusline by overriding their
      -- default behavior. For example, here we set the section for
      -- cursor location to LINE:COLUMN
      ---@diagnostic disable-next-line: duplicate-set-field
      statusline.section_location = function()
        return '%2l:%-2v'
      end

      -- ... and there is more!
      --  Check out: https://github.com/echasnovski/mini.nvim
    end,
  },

{
  "lukas-reineke/indent-blankline.nvim",
  main = "ibl",
  opts = {
    indent = {
      char = " ", -- The left-aligned triangle dot
      highlight = "LineNr", -- Dim color for all other lines
    },
    scope = {
        enabled = true, -- Turns on the feature for the cursor's line
        char = "╎",     -- Use the same dot (consistency)
        highlight = "Comment", -- Slightly brighter color for current scope
       show_start = false,
       show_end = false,
        include = {
          node_type = {
            python = { "for_statement", "while_statement", "if_statement", "with_statement", "try_statement", "class_definition", "function_definition" },
            lua = { "table_constructor", "function_declaration", "if_statement", "for_statement", "while_statement" },
          }
        },
      },
    }
  },
  {
    'nvim-treesitter/nvim-treesitter',
    branch = 'main',        -- Changed from 'master' to 'main'
    build = ':TSUpdate',
    main = 'nvim-treesitter.config',  -- Changed from 'nvim-treesitter.configs'
    -- ... rest of your config
  },
  {
    "lukas-reineke/headlines.nvim",
    dependencies = "nvim-treesitter/nvim-treesitter",
    config = function()
      require("headlines").setup({
        markdown = {
          -- headline_highlights = { "Headline1", "Headline2", "Headline3", "Headline4", "Headline5", "Headline6" },
          headline_highlights = { "Headline" },
          -- bullets = {'# ', '## '},
          bullets = {},
          codeblock_highlight = "CodeBlock", 
          dash_highlight = "Dash",
          quote_highlight = "Quote",
          fat_headlines = true,
          fat_headline_upper_string = "▂",
          fat_headline_lower_string = "🮂",
        },
      })
    end,
  },
  {
    "folke/zen-mode.nvim",
    config = function()
      require("zen-mode").setup({
        window = {
          width = 80,
          options = {
            number = false,
            relativenumber = false,
            signcolumn = "no",
            foldcolumn = "0",
          }
        },
        plugins = {
          gitsigns = { enabled = false },
          tmux = { enabled = false },
        },
      })

      -- Optional: add toggle keybinding
      vim.keymap.set('n', '<leader>Z', function()
        require("zen-mode").toggle()
      end, { desc = "Toggle zen mode" })
    end,
  },
  {
    "NeogitOrg/neogit",
    lazy = true,
    dependencies = {
      -- Only one of these is needed.
      --"sindrets/diffview.nvim",        -- optional
      -- "esmuellert/codediff.nvim",      -- optional

      -- For a custom log pager
      --"m00qek/baleia.nvim",            -- optional

      -- Only one of these is needed.
      "nvim-telescope/telescope.nvim", -- optional
    },
    cmd = "Neogit",
    keys = {
      { "<leader>gg", "<cmd>Neogit<cr>", desc = "Show Neogit UI" }
    }
  },

  {
    "zk-org/zk-nvim",
    name = "zk",
    config = function()
      local zk_todo_root
      local zk_todo_fetch
      local zk_todo_line
      local zk_todo_picker
      local zk_todo_open
      local action_layout = require("telescope.actions.layout")
      local zk = require("zk")
      local commands = require("zk.commands")
      local function make_edit_fn(defaults, picker_options)
        return function(options)
          options = vim.tbl_extend("force", defaults, options or {})
          zk.edit(options, picker_options)
        end
      end
      commands.add("ZkOrphans", make_edit_fn({ orphan = true }, { title = "Zk Orphans" }))
      commands.add("ZkRecents", make_edit_fn({ createdAfter = "2 weeks ago" }, { sort = { 'modified' }, title = "Zk Recents" }))
      local opts = { noremap = true, silent = false }
      vim.api.nvim_set_keymap("n", "<leader>zn", "<Cmd>ZkNew { title = vim.fn.input('Title: ') }<CR>", opts)
      vim.api.nvim_set_keymap("n", "<leader>zo", "<Cmd>ZkNotes { sort = { 'modified' } }<CR>", opts)
      vim.api.nvim_set_keymap("n", "<leader>zf", "<Cmd>ZkNotes { sort = { 'modified' }, match = { vim.fn.input('Search: ') } }<CR>", opts)
      vim.api.nvim_set_keymap("v", "<leader>zf", ":'<,'>ZkMatch<CR>", opts)
      -- TODO: move below outside of here
      function zk_todo_root()
        return require("zk.util").notebook_root(vim.fn.expand("%:p"))
        or require("zk.util").notebook_root(vim.fn.getcwd())
        or vim.env.ZK_NOTEBOOK_DIR
      end
      local function zk_todo_is_done(tag)
        return tag == "done" or tag:match("^done:") ~= nil
      end
      local function zk_todo_priority(tags)
        for _, tag in ipairs(tags or {}) do
          local p = tag:match("^prio:(.+)$") or tag:match("^priority:(.+)$")
          if p then
            return p
          end
        end
        return ""
      end
      local function zk_todo_visible_tags(tags)
        local out = {}
        for _, tag in ipairs(tags or {}) do
          local prio = tag:match("^prio:") or tag:match("^priority:")
          if tag ~= "todo" and not zk_todo_is_done(tag) and not prio then
            table.insert(out, "#" .. tag)
          end
        end
        return table.concat(out, " ")
      end
      local function done_marker(tags)
        for _, tag in ipairs(tags or {}) do
          if zk_todo_is_done(tag) then
            return "x "
          end
        end
        return "  "
      end
      function zk_todo_line(note, root)
        local prio = zk_todo_priority(note.tags)
        local tags = zk_todo_visible_tags(note.tags)
        local done = done_marker(note.tags) == "x "
        local marker
        if prio ~= "" then
          marker = (done and "x " or "  ") .. "(" .. prio .. ")"
        else
          marker = ""
        end
        local parts = {}
        if marker ~= "" then
          table.insert(parts, marker)
        end
        table.insert(parts, note.title)
        if tags ~= "" then
          table.insert(parts, tags)
        end
        table.insert(parts, note.path)
        return {
          done = done,
          prio = prio,
          has_prio = prio ~= "-",
          marker = marker,
          title = note.title,
          tags = tags,
          display = table.concat(parts, " "),
          path = vim.fs.joinpath(root, note.path),
        }
      end
      function zk_todo_picker(root, notes)
        local pickers = require("telescope.pickers")
        local finders = require("telescope.finders")
        local entry_display = require("telescope.pickers.entry_display")
        local action_state = require("telescope.actions.state")
        local conf = require("telescope.config").values
        local state = { root = root, notes = notes, sort_mode = 1, hide_done = true }
        local sort_names = { "priority", "title", "path" }
        local function zk_todo_title()
          return "zk todos" .. (state.hide_done and " (done hidden)" or "(all)")
        end
        local max_title = 0
        local max_tags = 0
        for _, note in pairs(notes) do
          local line = zk_todo_line(note, root)
          if line.title == nil then
            line.title = ""
          end
          max_title = math.max(max_title, vim.api.nvim_strwidth(line.title))
          max_tags = math.max(max_tags, vim.api.nvim_strwidth(line.tags))
        end
        max_title = math.min(max_title, 50)
        max_tags = math.min(max_tags, 40)
        local displayer = entry_display.create({
          separator = " ",
          items = {
            { width = 5 },
            { width = max_title },
            { width = max_tags > 0 and max_tags or nil },
            { remaining = true },
          },
        })
        local function make_display(entry)
          local has_prio = entry.prio ~= nil and entry.prio ~= "" and entry.prio ~= "-"
          local marker
          if entry.done and has_prio then
            marker = "x (" .. entry.prio .. ")"
          elseif entry.done then
            marker = "x    "
          elseif has_prio then
            marker = "  (" .. entry.prio .. ")"
          else
            marker = "     "
          end
          local prio_hl
          if entry.done then
            prio_hl = "TelescopeResultsComment" -- x AND prio both gray
          elseif entry.prio == "A" then
            prio_hl = "Error"
          elseif entry.prio == "B" then
            prio_hl = "Warning"
          elseif entry.prio == "C" then
            prio_hl = "Type"
          else
            prio_hl = "TelescopeResultsIdentifier"
          end
          local cols = {
            { marker, prio_hl },
            { entry.title, "TelescopeResultsFunction" },
          }
          if entry.tags and entry.tags ~= "" then
            table.insert(cols, { entry.tags, "Special" })
          else
            table.insert(cols, { "" })
          end
          local f = entry.filename:match("([^/]+)$")
          table.insert(cols, { f, "Comment" })
          return displayer(cols)
        end
        local function zk_todo_visible_notes(notes)
          -- filter out done tasks when hide_done is enabled
          if not state.hide_done then
            return notes
          end
          local out = {}
          for _, note in ipairs(notes) do
            if done_marker(note.tags) ~= "x " then
              table.insert(out, note)
            end
          end
          return out
        end
        local function zk_todo_finder(root, notes)
          local entries = {}
          for _, note in ipairs(zk_todo_visible_notes(notes)) do
            table.insert(entries, zk_todo_line(note, root))
          end
          return finders.new_table({
            results = entries,
            entry_maker = function(item)
              return {
                value = item.path,
                display = function(e)
                  return make_display(e)
                end,
                ordinal = item.display,
                path = item.path,
                filename = item.path,
                done = item.done,
                prio = item.prio,
                has_prio = item.has_prio,
                marker = item.marker,
                title = item.title,
                tags = item.tags,
              }
            end,
          })
        end
        local function prio_rank(p)
          return ({ A = 1, B = 2, C = 3 })[p] or 9
        end
        local function sort_notes(notes, mode)
          local sorted = vim.list_extend({}, notes)
          if mode == 1 then -- priority, undone first
            table.sort(sorted, function(a, b)
              local da, db = done_marker(a.tags) == "x ", done_marker(b.tags) == "x "
              if da ~= db then
                return not da
              end
              local pa, pb = prio_rank(zk_todo_priority(a.tags)), prio_rank(zk_todo_priority(b.tags))
              if pa ~= pb then
                return pa < pb
              end
              return a.path < b.path
            end)
          elseif mode == 2 then -- title
            table.sort(sorted, function(a, b)
              return (a.title or ""):lower() < (b.title or ""):lower()
            end)
          else -- path
            table.sort(sorted, function(a, b)
              return a.path < b.path
            end)
          end
          return sorted
        end
        local function toggle_done(path)
          local lines = vim.fn.readfile(path)
          local is_done = false
          for _, line in ipairs(lines) do
            if line:match("#done:%S+") or line:match("#done%f[%A]") then
              is_done = true
              break
            end
          end
          if not is_done then
            local last = #lines
            while last > 0 and lines[last]:match("^%s*$") do
              last = last - 1
            end
            if last > 0 then
              lines[last] = lines[last] .. " #done:" .. os.date("%Y-%m-%dT%H:%M")
            else
              lines = { "#done:" .. os.date("%Y-%m-%dT%H:%M") }
            end
            vim.fn.writefile(lines, path)
          else
            local out = {}
            for _, line in ipairs(lines) do
              local had_tag = line:match("#done:%S+") or line:match("#done%f[%A]")
              local stripped = line
              :gsub("%s-#done:%S+", "")
              :gsub("%s-#done%f[%A]", "")
              stripped = stripped:gsub("%s+$", "")
              if not (stripped:match("^%s*$") and had_tag) then
                table.insert(out, stripped)
              end
            end
            vim.fn.writefile(out, path)
          end
        end
        local function remove_prio(path)
          local lines = vim.fn.readfile(path)
          local out = {}
          for _, line in ipairs(lines) do
            local stripped = line:gsub("#prio:%S+", ""):gsub("#priority:%S+", "")
            local had_tag = line:match("#prio:%S+") or line:match("#priority:%S+")
            if not (stripped:match("^%s*$") and had_tag) then
              table.insert(out, stripped)
            end
          end
          vim.fn.writefile(out, path)
        end
        local function set_prio(path, prio)
          local lines = vim.fn.readfile(path)
          local out, replaced = {}, false
          for _, line in ipairs(lines) do
            if line:match("#prio:%S+") then
              line = line:gsub("#prio:%S+", "#prio:" .. prio)
              replaced = true
            end
            table.insert(out, line)
          end
          if not replaced then
            table.insert(out, "#prio:" .. prio)
          end
          vim.fn.writefile(out, path)
        end
        local function reindex_and_refresh(prompt_bufnr)
          local picker = action_state.get_current_picker(prompt_bufnr)
          require("zk.api").index(state.root, {}, function()
            zk_todo_fetch(state.root, function(notes)
              vim.schedule(function()
                if not vim.api.nvim_buf_is_valid(prompt_bufnr) then
                  return
                end
                state.notes = notes
                local selection = picker:get_selection_row()
                local callbacks = { unpack(picker._completion_callbacks) } -- shallow copy
                picker:register_completion_callback(function(self)
                  self:set_selection(selection)
                  self._completion_callbacks = callbacks
                end)
                picker:refresh(zk_todo_finder(root, notes), { reset_prompt = false })
              end)
            end)
          end)
        end
        local function with_entry(prompt_bufnr, fn)
          local entry = action_state.get_selected_entry()
          if not entry then
            return
          end
          vim.schedule(function()
            fn(entry.path, entry)
            reindex_and_refresh(prompt_bufnr)
          end)
        end
        local picker = pickers.new({
          layout_strategy = "horizontal",
          layout_config = {
            prompt_position = "top",
            height = 0.6, -- keep it low like ivy
            preview_width = 0.30, -- now actually honored
          },
          border = true,
        }, {
          sorting_strategy = "ascending",
          prompt_title = zk_todo_title(),
          finder = zk_todo_finder(root, notes),
          previewer = conf.qflist_previewer({}), -- must be called with opts
          sorter = conf.generic_sorter({}), -- must be called with opts
          attach_mappings = function(prompt_bufnr, map)
            map("n", "<Esc>", function() end)
            map("n", "<C-b>", function() end)
            map("n", "<C-n>", function() end)
            map("n", "<C-p>", function() end)
            map("n", "q", require("telescope.actions").close)
            map("n", "<C-c>", require("telescope.actions").close)
            map("i", "<C-c>", require("telescope.actions").close)
            local prio_ranks = { "A", "B", "C" }

            local function new_todo(prompt_bufnr)
              local title = vim.fn.input("Todo title: ")
              if title == nil or title == "" then
                return
              end
              local prio = vim.fn.input("Priority (A/B/C, empty for none): "):upper()
              local content = "#todo"
              if prio == "A" or prio == "B" or prio == "C" then
                content = content .. " #prio:" .. prio
              end
              local inbox_dir = "/inbox"
              print(state.root .. inbox_dir)
              require("zk.api").new(state.root .. inbox_dir, {
                title = title,
                content = content,
                edit = false,
              }, function(err, res)
                if err then
                  vim.notify(tostring(err), vim.log.levels.ERROR)
                  return
                end
                reindex_and_refresh(prompt_bufnr)
                vim.notify("created todo: " .. res.path, vim.log.levels.INFO)
              end)
            end


            map("n", "n", new_todo)
            map("i", "<C-g>n", new_todo)

            local function current_prio(entry)
              local p = entry.prio
              for i, r in ipairs(prio_ranks) do
                if p == r then
                  return i
                end
              end
              return nil -- no prio ("-")
            end
            local function cycle_prio_down(pb)
              with_entry(pb, function(path, entry)
                local i = current_prio(entry)
                if i == nil then
                  return -- nothing to do / nothing set
                elseif i < #prio_ranks then
                  set_prio(path, prio_ranks[i + 1])
                else
                  remove_prio(path)
                end
              end)
            end
            local function cycle_prio_up(pb)
              with_entry(pb, function(path, entry)
                local i = current_prio(entry)
                if i == nil then
                  set_prio(path, prio_ranks[#prio_ranks]) -- start from C
                elseif i > 1 then
                  set_prio(path, prio_ranks[i - 1])
                end
              end)
            end
            local function bind(mode, lhs, fn)
              vim.keymap.set(mode, lhs, function()
                fn(prompt_bufnr)
              end, { buffer = prompt_bufnr })
            end
            bind("n", ">", cycle_prio_down)
            bind("n", "<", cycle_prio_up)
            bind("i", "<c-g>>", cycle_prio_down)
            bind("i", "<c-g><", cycle_prio_up)
            vim.keymap.set("n", "<Esc>", function() end, { buffer = prompt_bufnr })
            bind("i", "<C-g><C-g>", function(pb)
              with_entry(pb, toggle_done)
            end)
            bind("i", "<C-g><C-p>", function()
              action_layout.toggle_preview(prompt_bufnr)
            end)
            bind("n", "P", function()
              action_layout.toggle_preview(prompt_bufnr)
            end)
            local function do_sort(pb)
              state.sort_mode = state.sort_mode % #sort_names + 1
              vim.notify("zk todos sorted by " .. sort_names[state.sort_mode], vim.log.levels.INFO)
              local picker = action_state.get_current_picker(pb)
              local selection = picker:get_selection_row()
              picker:refresh(zk_todo_finder(state.root, sort_notes(state.notes, state.sort_mode)), {
                reset_prompt = false,
              })
              picker:set_selection(selection)
            end
            bind("i", "<C-g>s", do_sort)
            bind("n", "s", do_sort)
            local function toggle_hide_done(pb)
              state.hide_done = not state.hide_done
              local picker = action_state.get_current_picker(pb)
              local selection = picker:get_selection_row()
              picker:refresh(
                zk_todo_finder(state.root, sort_notes(state.notes, state.sort_mode)),
                { reset_prompt = false }
              )

              picker.prompt_border:change_title(zk_todo_title())
              vim.schedule(function()
                pcall(function()
                  picker:set_selection(math.min(selection, #picker.manager.results - 1))
                end)
              end)
              vim.notify(
                "done tasks " .. (state.hide_done and "hidden" or "shown"),
                vim.log.levels.INFO
              )
            end
            bind("i", "<C-g>d", toggle_hide_done)
            bind("n", "d", toggle_hide_done)
            bind("n", "<C-g><C-g>", function(pb)
              with_entry(pb, toggle_done)
            end)
            bind("n", "<C-g>a", function(pb)
              with_entry(pb, function(p)
                set_prio(p, "A")
              end)
            end)
            bind("n", "<C-g>b", function(pb)
              with_entry(pb, function(p)
                set_prio(p, "B")
              end)
            end)
            bind("n", "<C-g>c", function(pb)
              with_entry(pb, function(p)
                set_prio(p, "C")
              end)
            end)
            bind("n", "<C-g>x", function(pb)
              with_entry(pb, remove_prio)
            end)
            return true
          end,
        })
        picker:find()
        vim.schedule(function()
          action_layout.toggle_preview(picker.prompt_bufnr)
        end)
      end
      function zk_todo_fetch(root, on_notes)
        require("zk.api").list(root, {
          tags = { "todo" },
          sort = { "path" },
          select = { "title", "path", "absPath", "tags" },
        }, function(err, notes)
          if err then
            vim.notify(tostring(err), vim.log.levels.ERROR)
            print("ERROR: " .. tostring(err))
            return
          end
          on_notes(notes)
        end)
      end
      zk_todo_open = function()
        local root = zk_todo_root()
        if not root then
          vim.notify("No zk notebook found", vim.log.levels.ERROR)
          return
        end
        zk_todo_fetch(root, function(notes)
          zk_todo_picker(root, notes)
        end)
      end
      vim.keymap.set("n", "<leader>T", zk_todo_open, { desc = "Open zk todos" })
      if require("zk.util").notebook_root(vim.fn.expand("%:p")) ~= nil then
        local function map(...) vim.api.nvim_buf_set_keymap(0, ...) end
        local opts = { noremap = true, silent = false }
        map("n", "<CR>", "<Cmd>lua vim.lsp.buf.definition()<CR>", opts)
        map("n", "<leader>zn", "<Cmd>ZkNew { dir = vim.fn.expand('%:p:h'), title = vim.fn.input('Title: ') }<CR>", opts)
        map("v", "<leader>znt", ":'<,'>ZkNewFromTitleSelection { dir = vim.fn.expand('%:p:h') }<CR>", opts)
        map("v", "<leader>znc", ":'<,'>ZkNewFromContentSelection { dir = vim.fn.expand('%:p:h'), title = vim.fn.input('Title: ') }<CR>", opts)
        map("n", "<leader>zb", "<Cmd>ZkBacklinks<CR>", opts)
        map("n", "<leader>zl", "<Cmd>ZkLinks<CR>", opts)
        map("n", "K", "<Cmd>lua vim.lsp.buf.hover()<CR>", opts)
        map("v", "<leader>za", ":'<,'>lua vim.lsp.buf.range_code_action()<CR>", opts)
      end
      zk.setup({
        picker = "telescope",
        picker_options = {
          telescope = require("telescope.themes").get_ivy(),
        },
        lsp = {
          config = {
            name = "zk",
            cmd = { "zk", "lsp" },
            filetypes = { "markdown" },
          },
          auto_attach = {
            enabled = true,
          },
        },
      })
    end,
  },

  {
    "timantipov/md-table-tidy.nvim",
    ft = { "markdown" },
    dependencies = {
      "nvim-treesitter/nvim-treesitter",
    },
    opts = {
      padding = 1,
      keymap = {
        table_tidy = "<leader>tt",
        table_tidy_all = "<leader>ta",
      },
    },
  },

}
