return {
  -- You can also add new plugins here as well:
  -- Add plugins, the lazy syntax
  {
    "Shatur/neovim-session-manager",
    enabled = false,
  },
  {
    "ray-x/lsp_signature.nvim",
    event = "BufRead",
    config = function() require("lsp_signature").setup() end,
  },
  {
    "mfussenegger/nvim-dap",
    enabled = false,
  },
  {
    "rhysd/clever-f.vim",
    event = { "BufReadPost", "BufAdd", "BufNewFile" },
    config = function()
      vim.api.nvim_set_hl(
        0,
        "CleverChar",
        { underline = true, bold = true, fg = "Orange", bg = "NONE", ctermfg = "Red", ctermbg = "NONE" }
      )
      vim.g.clever_f_mark_char_color = "CleverChar"
      vim.g.clever_f_mark_direct_color = "CleverChar"
      vim.g.clever_f_mark_direct = true
      vim.g.clever_f_timeout_ms = 1500
    end,
  },
  {
    "phaazon/hop.nvim",
    branch = "v2",
    event = "BufWinEnter",
    config = function() require("hop").setup { keys = "etovxqpdygfblzhckisuran" } end,
  },
  {
    "simeji/winresizer",
    cmd = "WinResizerStartResize",
    keys = { "<C-e>" },
    config = function(_, _) vim.g.winresizer_finish_with_escape = 1 end,
  },
  {
    "Wansmer/treesj",
    dependencies = { "nvim-treesitter" },
    opts = {
      use_default_keymaps = false,
      max_join_length = 120,
    },
    keys = {
      { "<leader>ts", "<Cmd>TSJSplit<CR>", desc = "TreeSJ Split" },
      { "<leader>tj", "<Cmd>TSJJoin<CR>", desc = "TreeSJ Join" },
      { "<leader>m", "<Cmd>TSJToggle<CR>", desc = "TreeSJ Toggle" },
    },
    config = function(_, opts) require("treesj").setup(opts) end,
  },
  {
    "rainbowhxch/accelerated-jk.nvim",
    event = "BufRead",
    opts = {
      mode = "time_driven",
      enable_deceleration = false,
      acceleration_motions = {},
      acceleration_limit = 150,
      acceleration_table = { 7, 12, 17, 21, 24, 26, 28, 30 },
      -- when 'enable_deceleration = true', 'deceleration_table = { {200, 3}, {300, 7}, {450, 11}, {600, 15}, {750, 21}, {900, 9999} }'
      deceleration_table = { { 150, 9999 } },
    },
    config = function(_, opts)
      require("accelerated-jk").setup(opts)

      vim.api.nvim_set_keymap("n", "j", "<Plug>(accelerated_jk_gj)", {})
      vim.api.nvim_set_keymap("n", "k", "<Plug>(accelerated_jk_gk)", {})
    end,
  },

  {
    "akinsho/toggleterm.nvim",
    enabled = false,
  },
}
