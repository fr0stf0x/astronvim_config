return {
  "echasnovski/mini.move",
  keys = {
    { "<A-S-h>", mode = "n", desc = "Move line left" },
    { "<A-S-j>", mode = "n", desc = "Move line down" },
    { "<A-S-k>", mode = "n", desc = "Move line up" },
    { "<A-S-l>", mode = "n", desc = "Move line right" },
    { "<A-S-h>", mode = "v", desc = "Move selection left" },
    { "<A-S-j>", mode = "v", desc = "Move selection down" },
    { "<A-S-k>", mode = "v", desc = "Move selection up" },
    { "<A-S-l>", mode = "v", desc = "Move selection right" },
  },
  opts = {
    mappings = {
      left = "<A-S-h>",
      right = "<A-S-l>",
      down = "<A-S-j>",
      up = "<A-S-k>",
      line_left = "<A-S-h>",
      line_right = "<A-S-l>",
      line_down = "<A-S-j>",
      line_up = "<A-S-k>",
    },
  },
}
