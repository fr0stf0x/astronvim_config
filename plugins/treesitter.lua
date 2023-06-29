return {
  "nvim-treesitter/nvim-treesitter",
  dependencies = {
    "andymass/vim-matchup",
    config = function() vim.g.matchup_matchparen_offscreen = { method = "popup" } end,
  },
  opts = function(_, opts)
    -- add more things to the ensure_installed table protecting against community packs modifying it
    opts.ensure_installed = require("astronvim.utils").list_insert_unique(opts.ensure_installed, {
      "css",
      "markdown",
      "html",
      "yaml",
    })
    opts.matchup = {
      enable = true,
    }
  end,
}
