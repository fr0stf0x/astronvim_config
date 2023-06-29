return {
  "nvim-tree/nvim-tree.lua",
  cmd = {
    "NvimTreeToggle",
    "NvimTreeFocus",
  },
  dependencies = {
    "nvim-tree/nvim-web-devicons",
  },
  config = function()
    local icons = {
      diagnostics = require("user.configs.icons").get "diagnostics",
      documents = require("user.configs.icons").get "documents",
      git = require("user.configs.icons").get "git",
      ui = require("user.configs.icons").get "ui",
    }

    require("nvim-tree").setup {
      disable_netrw = true,
      hijack_netrw = true,
      hijack_cursor = true,
      hijack_unnamed_buffer_when_opening = false,
      sync_root_with_cwd = true,
      update_focused_file = {
        enable = true,
        update_root = false,
      },
      view = {
        adaptive_size = false,
        side = "left",
        width = 50,
        preserve_window_proportions = true,
      },
      git = {
        enable = true,
        ignore = false,
        -- show_on_dirs = true,
        timeout = 400,
      },
      filesystem_watchers = {
        enable = true,
      },
      actions = {
        open_file = {
          resize_window = true,
        },
      },
      filters = {
        dotfiles = false,
        custom = { ".DS_Store", "^\\.git$" },
        exclude = {},
      },
      renderer = {
        root_folder_label = true,
        -- root_folder_label = ":.:s?.*?/..?",
        highlight_git = true,
        highlight_opened_files = "none",

        -- indent_markers = {
        --   enable = false,
        -- },

        indent_markers = {
          enable = true,
          icons = {
            corner = "└ ",
            edge = "│ ",
            item = "│ ",
            none = "  ",
          },
        },
        icons = {
          webdev_colors = true,
          show = {
            file = true,
            folder = true,
            folder_arrow = true,
            git = true,
          },

          git_placement = "after",
          padding = " ",
          symlink_arrow = " 󰁔 ",

          glyphs = {
            default = icons.documents.Default, --
            symlink = icons.documents.Symlink, --
            bookmark = icons.ui.Bookmark,
            git = {
              unstaged = icons.git.Mod_alt,
              staged = icons.git.Add, --󰄬
              unmerged = icons.git.Unmerged,
              renamed = icons.git.Rename, --󰁔
              untracked = icons.git.Untracked, -- "󰞋"
              deleted = icons.git.Remove, --
              ignored = icons.git.Ignore, --◌
            },
            folder = {
              arrow_open = icons.ui.ArrowOpen,
              arrow_closed = icons.ui.ArrowClosed,
              -- arrow_open = "",
              -- arrow_closed = "",
              default = icons.ui.Folder,
              open = icons.ui.FolderOpen,
              empty = icons.ui.EmptyFolder,
              empty_open = icons.ui.EmptyFolderOpen,
              symlink = icons.ui.SymlinkFolder,
              symlink_open = icons.ui.FolderOpen,
            },
          },
        },
      },
      on_attach = function(bufnr)
        local api = require "nvim-tree.api"
        local openfile = require "nvim-tree.actions.node.open-file"

        local actions = require "telescope.actions"
        local action_state = require "telescope.actions.state"

        api.config.mappings.default_on_attach(bufnr)

        local function opts(desc)
          return { desc = "NvimTree: " .. desc, buffer = bufnr, noremap = true, silent = true, nowait = true }
        end

        local function edit_or_open()
          local node = api.tree.get_node_under_cursor()

          if node.nodes ~= nil then
            -- expand or collapse folder
            api.node.open.edit()
          else
            -- open file
            api.node.open.edit()
          end
        end

        -- open as vsplit on current node
        local function vsplit_open()
          local node = api.tree.get_node_under_cursor()

          if node.nodes ~= nil then
            -- expand or collapse folder
            api.node.open.edit()
          else
            -- open file as vsplit
            api.node.open.vertical()
          end
        end

        local function split_open()
          local node = api.tree.get_node_under_cursor()

          if node.nodes ~= nil then
            -- expand or collapse folder
            api.node.open.edit()
          else
            -- open file as vsplit
            api.node.open.horizontal()
          end
        end

        local view_selection = function(prompt_bufnr, map)
          actions.select_default:replace(function()
            actions.close(prompt_bufnr)
            local selection = action_state.get_selected_entry()
            local filename = selection.filename
            if filename == nil then filename = selection[1] end
            openfile.fn("preview", filename)
          end)
          return true
        end

        local function launch_telescope(func_name, opts)
          local telescope_status_ok, _ = pcall(require, "telescope")
          if not telescope_status_ok then return end
          local node = api.tree.get_node_under_cursor()
          local is_folder = node.fs_stat and node.fs_stat.type == "directory" or false
          local basedir = is_folder and node.absolute_path or vim.fn.fnamemodify(node.absolute_path, ":h")
          if node.name == ".." and TreeExplorer ~= nil then basedir = TreeExplorer.cwd end
          opts = opts or {}
          opts.cwd = basedir
          opts.search_dirs = { basedir }
          opts.attach_mappings = view_selection
          return require("telescope.builtin")[func_name](opts)

          -- return require("telescope").extensions.live_grep_args.live_grep_args(opts)
          -- return require("telescope").extensions.live_grep_args.live_grep_args {
          --   search_dirs = { basedir },
          -- }
        end

        local function launch_live_grep(opts) return launch_telescope("live_grep", opts) end

        vim.keymap.set("n", "l", edit_or_open, opts "Edit Or Open")
        vim.keymap.set("n", "s", vsplit_open, opts "Vsplit Preview")
        vim.keymap.set("n", "S", split_open, opts "Split Preview")
        -- vim.keymap.set("n", "h", api.tree.close, opts "Close")
        vim.keymap.set("n", "A", api.tree.collapse_all, opts "Collapse All")

        vim.keymap.set("n", "<c-f>", launch_live_grep, opts "Launch Live Grep")
      end,
    }
  end,
}
