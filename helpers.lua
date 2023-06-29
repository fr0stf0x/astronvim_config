local M = {}

M.diagnostic_goto = function (next, severity)
  local goto = next and vim.diagnostic.goto_next or vim.diagnostic.goto_prev
	severity = severity and vim.diagnostic.severity[severity] or nil

	return function()
		goto({ severity = severity })
	end
end

M.starts_with = function(str, start)
   return str:sub(1, #start) == start
end

return M
