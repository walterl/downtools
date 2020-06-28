local function get_line_nr()
	return vim.api.nvim_win_get_cursor(0)[1]
end

local function get_current_line()
	return vim.api.nvim_get_current_line()
end

local function get_mark_col(mark)
	return vim.api.nvim_buf_get_mark(0, mark)[2]
end

local function set_line(n, line)
	vim.api.nvim_buf_set_lines(0, n-1, n, false, {line})
end

local function set_current_line(line)
	set_line(get_line_nr(), line)
end

local function set_cursor(row, col)
	vim.api.nvim_win_set_cursor(0, {row, col})
end

----------------------
-- toggle_list_item --
----------------------

local function is_list_item_line(line)
	if line:find("*") == 1 then
		return true
	end
	return false
end

local function is_todo_item_line(line)
	if line:sub(1, 1) == "[" and line:sub(3, 3) == "]" then
		return true
	end
	return false
end

local function toggle_todo_mark(mark)
	print("mark:", mark)
	if mark == " " then
		return "X"
	elseif mark == "X" then
		return " "
	end
	return mark
end

local function toggle_list_item_line(line)
	orig_line = line
	leading_space = line:match("^[\t ]+")
	if leading_space == nil then
		leading_space = ""
	end

	line = vim.trim(line)

	if not is_list_item_line(line) then
		return leading_space .. '* ' .. line
	end

	line = line:sub(3)

	if not is_todo_item_line(line) then
		return leading_space .. '* [ ] ' .. line
	end

	todo_mark = toggle_todo_mark(line:sub(2, 2))
	line = line:sub(4)

	if todo_mark == " " or todo_mark == "X" then
		return leading_space .. '* [' .. todo_mark .. ']' .. line
	end

	return orig_line
end

local function toggle_list_item()
	set_current_line(toggle_list_item_line(get_current_line()))
end

-----------
-- vlink --
-----------

local function vlink_line(line, startpos, endpos)
	local link_text = line:sub(startpos+1, endpos+1)

	if link_text == "" then
		return line
	end

	local before = line:sub(0, startpos)
	local after = line:sub(endpos+2)

	return before .. "[" .. link_text .. "]()" .. after
end

local function vlink()
	local linenr = get_line_nr()
	local endpos = get_mark_col(">")
	local updated_line = vlink_line(get_current_line(), get_mark_col("<"), endpos)
	set_line(linenr, updated_line)
	-- Move cursor to closing paren, so that user can `i`nsert/`P`aste there
	set_cursor(linenr, endpos+4)
end

return {
	toggle_list_item = toggle_list_item,
	vlink = vlink
}
