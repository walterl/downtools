local function mdlink()
	local linenr = vim.api.nvim_win_get_cursor(0)[1]
	local line = vim.api.nvim_get_current_line()
	local startpos = vim.api.nvim_buf_get_mark(0, "<")[2]
	local endpos = vim.api.nvim_buf_get_mark(0, ">")[2]

	local link_text = line:sub(startpos+1, endpos+1)

	if link_text == "" then
		return
	end

	local before = line:sub(0, startpos)
	local after = line:sub(endpos+2)

	local updated_line = before .. "[" .. link_text .. "]()" .. after
	vim.api.nvim_buf_set_lines(0, linenr-1, linenr, false, {updated_line})

	-- Move cursor to closing paren, so that user can `i`nsert/`P`aste there
	vim.api.nvim_win_set_cursor(0, {linenr, endpos+4})
end

return {
	mdlink = mdlink
}
