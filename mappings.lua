local diagnostic_goto = require("user.helpers").diagnostic_goto

-- Mapping data with "desc" stored directly by vim.keymap.set().
--
-- Please use this mappings table to set keyboard mapping since this is the
-- lower level configuration and more robust one. (which-key will
-- automatically pick-up stored data by this setting.)
return {
  -- first key is the mode
  n = {
    -- second key is the lefthand side of the map
    -- mappings seen under group name "Buffer"
    ["c"] = { '"_c' },
    ["C"] = { '"_C' },
    ["x"] = { '"_x' },
    ["X"] = { '"_X' },

    ["<C-c>"] = { "<cmd> %y+ <cr>", desc = "Copy file" },
    ["<C-S-s>"] = { "wall", desc = "edit: Save all files" },

    ["<Tab>"] = {
      function() require("astronvim.utils.buffer").nav(vim.v.count > 0 and vim.v.count or 1) end,
      desc = "Next buffer",
    },
    ["<S-Tab>"] = {
      function() require("astronvim.utils.buffer").nav(-(vim.v.count > 0 and vim.v.count or 1)) end,
      desc = "Previous buffer",
    },
    ["<leader>x"] = {
      function()
        local bufs = vim.fn.getbufinfo { buflisted = true }
        require("astronvim.utils.buffer").close(0)
        if require("astronvim.utils").is_available "alpha-nvim" and not bufs[2] then require("alpha").start(true) end
      end,
      desc = "Close buffer",
    },
    ["<leader>bC"] = {
      function()
        require("astronvim.utils.buffer").close_all()
        require("alpha").start(true)
      end,
      desc = "Close all buffers",
    },
    ["<leader>bD"] = {
      function()
        require("astronvim.utils.status").heirline.buffer_picker(
          function(bufnr) require("astronvim.utils.buffer").close(bufnr) end
        )
      end,
      desc = "Pick to close",
    },
    ["<C-/>"] = {
      function() require("Comment.api").toggle.linewise.count(vim.v.count > 0 and vim.v.count or 1) end,
      desc = "Toggle comment line",
    },

    ["<C-w>f"] = {
      "<cmd>CloseAllFloatingWindows<cr>",
      desc = "Close all floating windows",
    },

    -- tables with the `name` key will be registered with which-key if it's installed
    -- this is useful for naming menus
    ["<leader>b"] = { name = "Buffers" },
    ["<C-n>"] = { "<Cmd>NvimTreeToggle<CR>", desc = "NvimTree: Toggle" },
    ["<leader>e"] = { "<Cmd>NvimTreeFocus<CR>", desc = "NvimTree: Focus" },

    -- Telescope
    ["<leader>fz"] = {
      "<Cmd> Telescope current_buffer_fuzzy_find <CR>",
      desc = "find: Word in file",
    },
    ["<leader>fp"] = {
      function() require("telescope").extensions.projects.projects {} end,
      desc = "find: Project",
    },
    ["<leader>fs"] = { "<cmd>Telescope grep_string<cr>", desc = "find: Current word" },

    -- LSP
    ["<leader>o"] = { function() require("aerial").toggle() end, desc = "Symbols outline" },

    ["[w"] = { diagnostic_goto(false, "WARN"), desc = "lsp: Prev error" },
    ["]w"] = { diagnostic_goto(true, "WARN"), desc = "lsp: Next error" },
    ["[e"] = { diagnostic_goto(false, "ERROR"), desc = "lsp: Prev error" },
    ["]e"] = { diagnostic_goto(true, "ERROR"), desc = "lsp: Next error" },

    -- Motion
    ["<leader>w"] = { "<Cmd>HopWord<CR>", desc = "jump: Goto word" },
    ["<leader>j"] = { "<Cmd>HopLine<CR>", desc = "jump: Goto line" },
    ["<leader>k"] = { "<Cmd>HopLine<CR>", desc = "jump: Goto line" },

    ["<leader>D"] = { "<Cmd>DiffviewOpen<CR>", desc = "Diffview: Open" },
    ["<leader><leader>D"] = { "<Cmd>DiffviewClose<CR>", desc = "Diffview: Close" },

    -- Disable default mappings
    ["<leader>c"] = false,
    ["<leader>C"] = false,
    ["]b"] = false,
    ["[b"] = false,
  },
  v = {
    ["<C-/>"] = {
      "<esc><cmd>lua require('Comment.api').toggle.linewise(vim.fn.visualmode())<cr>",
      desc = "Toggle comment for selection",
    },
    ["<C-\\>"] = {
      "<esc><cmd>lua require('Comment.api').toggle.blockwise(vim.fn.visualmode())<cr>",
    },
    -- ["<leader>/"] = false,
  },
  i = {
    ["<C-a>"] = { "<Home>", desc = "edit: Home" },
    ["<C-e>"] = { "<End>", desc = "edit: End" },
    ["<C-b>"] = { "<BS>" },
    ["<C-h>"] = { "<Left>" },
    ["<C-l>"] = { "<Right>" },
    ["<C-j>"] = { "<Down>" },
    ["<C-k>"] = { "<Up>" },
  },
}
