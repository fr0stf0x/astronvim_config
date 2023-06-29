return {
  {
    "hrsh7th/nvim-cmp",
    opts = function(_, opts)
      local cmp = require "cmp"
      local compare = require "cmp.config.compare"

      compare.lsp_scores = function(entry1, entry2)
        local diff
        if entry1.completion_item.score and entry2.completion_item.score then
          diff = (entry2.completion_item.score * entry2.score) - (entry1.completion_item.score * entry1.score)
        else
          diff = entry2.score - entry1.score
        end
        return (diff < 0)
      end

      -- Copy from nvimdots' config
      opts.preselect = cmp.PreselectMode.Item
      opts.sorting = {
        priority_weight = 2,
        comparators = {
          -- require("cmp_tabnine.compare"),
          compare.offset, -- Items closer to cursor will have lower priority
          compare.exact,
          -- compare.scopes,
          compare.lsp_scores,
          compare.sort_text,
          compare.score,
          compare.recently_used,
          -- compare.locality, -- Items closer to cursor will have higher priority, conflicts with `offset`
          compare.kind,
          compare.length,
          compare.order,
        },
      }

      opts.formatting.fields = { "abbr", "kind", "menu" }

      local helpers = require "user.helpers"

      if helpers.starts_with(vim.g.colors_name, "catppuccin") then
        local border = function(hl)
          return {
            -- more rounded
            { "╭", hl },
            { "─", hl },
            { "╮", hl },
            { "│", hl },
            { "╯", hl },
            { "─", hl },
            { "╰", hl },
            { "│", hl },
          }
        end

        opts.window.completion = {
          border = border "PmenuBorder",
          winhighlight = "Normal:Pmenu,CursorLine:PmenuSel,Search:PmenuSel",
          scrollbar = false,
        }

        opts.window.documentation = {
          border = border "CmpDocBorder",
          winhighlight = "Normal:CmpDoc",
        }
      end

      return opts
    end,
  },
  {
    "onsails/lspkind.nvim",
    opts = function(_, opts) opts.mode = "symbol_text" end,
  },
}
