---@class palette
---@field rosewater string
---@field flamingo string
---@field mauve string
---@field pink string
---@field red string
---@field maroon string
---@field peach string
---@field yellow string
---@field green string
---@field sapphire string
---@field blue string
---@field sky string
---@field teal string
---@field lavender string
---@field text string
---@field subtext1 string
---@field subtext0 string
---@field overlay2 string
---@field overlay1 string
---@field overlay0 string
---@field surface2 string
---@field surface1 string
---@field surface0 string
---@field base string
---@field mantle string
---@field crust string
---@field none "NONE"

return {
  "catppuccin/nvim",
  name = "catppuccin",
  priority = 1000,
  config = function()
    local transparent_background = false
    local clear = {}

    require("catppuccin").setup {
      flavour = "macchiato", -- Can be one of: latte, frappe, macchiato, mocha
      background = { light = "latte", dark = "macchiato" },
      dim_inactive = {
        -- Dim inactive splits/windows/buffers.
        enabled = true,
        -- NOT recommended if you use old palette (a.k.a., mocha).
        shade = "dark",
        percentage = 0.15,
      },
      transparent_background = transparent_background,
      show_end_of_buffer = false, -- show the '~' characters after the end of buffers
      term_colors = true,
      compile_path = vim.fn.stdpath "cache" .. "/catppuccin",
      styles = {
        comments = { "italic" },
        properties = {},
        keywords = { "italic" },
        -- operators = { "bold" },
        -- functions = { "bold" },
        -- conditionals = { "bold" },
        -- loops = { "bold" },
        booleans = { "italic" },
        numbers = {},
        types = {},
        strings = {},
        variables = {},
      },
      integrations = {
        treesitter = true,
        native_lsp = {
          enabled = true,
          virtual_text = {
            errors = { "italic" },
            hints = { "italic" },
            warnings = { "italic" },
            information = { "italic" },
          },
          underlines = {
            errors = { "underline" },
            hints = { "underline" },
            warnings = { "underline" },
            information = { "underline" },
          },
        },
        aerial = true,
        alpha = true,
        barbar = false,
        beacon = false,
        cmp = true,
        coc_nvim = false,
        dap = { enabled = false, enable_ui = false },
        dashboard = false,
        fern = false,
        fidget = false,
        gitgutter = false,
        gitsigns = true,
        harpoon = false,
        hop = true,
        illuminate = false,
        indent_blankline = { enabled = true, colored_indent_levels = false },
        leap = false,
        lightspeed = false,
        lsp_saga = false,
        lsp_trouble = false,
        markdown = true,
        mason = true,
        dropbar = { enabled = false },
        ts_rainbow2 = false,
        mini = false,
        navic = { enabled = false },
        neogit = false,
        neotest = false,
        neotree = { enabled = false, show_root = true, transparent_panel = false },
        noice = false,
        notify = true,
        nvimtree = true,
        overseer = false,
        pounce = false,
        semantic_tokens = true,
        symbols_outline = false,
        telekasten = false,
        telescope = { enabled = true, style = "classic" },
        treesitter_context = false,
        ts_rainbow = false,
        vim_sneak = false,
        vimwiki = false,
        which_key = true,
      },
      color_overrides = {},
      highlight_overrides = {
        ---@param cp palette
        all = function(cp)
          return {
            -- For base configs
            NormalFloat = { fg = cp.text, bg = transparent_background and cp.none or cp.mantle },
            FloatBorder = {
              fg = transparent_background and cp.blue or cp.mantle,
              bg = transparent_background and cp.none or cp.mantle,
            },
            CursorLineNr = { fg = cp.green },

            -- For native lsp configs
            DiagnosticVirtualTextError = { bg = cp.none },
            DiagnosticVirtualTextWarn = { bg = cp.none },
            DiagnosticVirtualTextInfo = { bg = cp.none },
            DiagnosticVirtualTextHint = { bg = cp.none },
            LspInfoBorder = { link = "FloatBorder" },

            -- For mason.nvim
            MasonNormal = { link = "NormalFloat" },

            -- For indent-blankline
            IndentBlanklineChar = { fg = cp.surface0 },
            IndentBlanklineContextChar = { fg = cp.surface2, style = { "bold" } },

            -- For nvim-cmp and wilder.nvim
            Pmenu = { fg = cp.overlay2, bg = transparent_background and cp.none or cp.base },
            PmenuBorder = { fg = cp.surface1, bg = transparent_background and cp.none or cp.base },
            PmenuSel = { bg = cp.green, fg = cp.base },
            CmpItemAbbr = { fg = cp.overlay2 },
            CmpItemAbbrMatch = { fg = cp.blue, style = { "bold" } },
            CmpDoc = { link = "NormalFloat" },
            CmpDocBorder = {
              fg = transparent_background and cp.surface1 or cp.mantle,
              bg = transparent_background and cp.none or cp.mantle,
            },

            -- CmpItemKindSnippet = { fg = cp.base, bg = cp.mauve },
            -- CmpItemKindKeyword = { fg = cp.base, bg = cp.red },
            -- CmpItemKindText = { fg = cp.base, bg = cp.teal },
            -- CmpItemKindMethod = { fg = cp.base, bg = cp.blue },
            -- CmpItemKindConstructor = { fg = cp.base, bg = cp.blue },
            -- CmpItemKindFunction = { fg = cp.base, bg = cp.blue },
            -- CmpItemKindFolder = { fg = cp.base, bg = cp.blue },
            -- CmpItemKindModule = { fg = cp.base, bg = cp.blue },
            -- CmpItemKindConstant = { fg = cp.base, bg = cp.peach },
            -- CmpItemKindField = { fg = cp.base, bg = cp.green },
            -- CmpItemKindProperty = { fg = cp.base, bg = cp.green },
            -- CmpItemKindEnum = { fg = cp.base, bg = cp.green },
            -- CmpItemKindUnit = { fg = cp.base, bg = cp.green },
            -- CmpItemKindClass = { fg = cp.base, bg = cp.yellow },
            -- CmpItemKindVariable = { fg = cp.base, bg = cp.flamingo },
            -- CmpItemKindFile = { fg = cp.base, bg = cp.blue },
            -- CmpItemKindInterface = { fg = cp.base, bg = cp.yellow },
            -- CmpItemKindColor = { fg = cp.base, bg = cp.red },
            -- CmpItemKindReference = { fg = cp.base, bg = cp.red },
            -- CmpItemKindEnumMember = { fg = cp.base, bg = cp.red },
            -- CmpItemKindStruct = { fg = cp.base, bg = cp.blue },
            -- CmpItemKindValue = { fg = cp.base, bg = cp.peach },
            -- CmpItemKindEvent = { fg = cp.base, bg = cp.blue },
            -- CmpItemKindOperator = { fg = cp.base, bg = cp.blue },
            -- CmpItemKindTypeParameter = { fg = cp.base, bg = cp.blue },
            -- CmpItemKindCopilot = { fg = cp.base, bg = cp.teal },

            -- For fidget
            FidgetTask = { bg = cp.none, fg = cp.surface2 },
            FidgetTitle = { fg = cp.blue, style = { "bold" } },

            -- For nvim-tree
            NvimTreeRootFolder = { fg = cp.pink },
            NvimTreeIndentMarker = { fg = cp.surface0 },

            -- For trouble.nvim
            TroubleNormal = { bg = transparent_background and cp.none or cp.base },

            -- For telescope.nvim
            TelescopeBorder = {
              fg = transparent_background and cp.blue or cp.mantle,
              bg = transparent_background and cp.none or cp.mantle,
            },
            TelescopePromptBorder = {
              fg = transparent_background and cp.blue or cp.surface0,
              bg = transparent_background and cp.none or cp.surface0,
            },
            TelescopePromptNormal = {
              fg = cp.text,
              bg = transparent_background and cp.none or cp.surface0,
            },
            TelescopePromptPrefix = {
              fg = cp.flamingo,
              bg = transparent_background and cp.none or cp.surface0,
            },
            TelescopeNormal = {
              bg = transparent_background and cp.none or cp.mantle,
            },
            TelescopePreviewTitle = {
              fg = transparent_background and cp.green or cp.base,
              bg = transparent_background and cp.none or cp.green,
            },
            TelescopePromptTitle = {
              fg = transparent_background and cp.red or cp.base,
              bg = transparent_background and cp.none or cp.red,
            },
            TelescopeResultsTitle = {
              fg = cp.mantle,
              bg = transparent_background and cp.none or cp.mantle,
            },
            TelescopeSelection = {
              fg = cp.green,
              bg = transparent_background and cp.none or cp.surface0,
            },
            TelescopeResultsDiffAdd = { fg = cp.green },
            TelescopeResultsDiffChange = { fg = cp.yellow },
            TelescopeResultsDiffDelete = { fg = cp.red },

            -- For treesitter
            ["@keyword.return"] = { fg = cp.pink, style = clear },
          }
        end,
      },
    }
  end,
}
