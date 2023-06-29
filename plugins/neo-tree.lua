return {
  "nvim-neo-tree/neo-tree.nvim",
  enabled = false,
  opts = function(_, opts)
    local index
    for i, value in pairs(opts.source_selector.sources) do
      if value.source == "buffers" then index = i end
    end

    if index >= 1 then table.remove(opts.source_selector.sources, index) end

    return opts
  end,
}
