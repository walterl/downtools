local function get_indent(line)
	return line:match("^%s+") or ""
end

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
local function get_line_list_marker(line)
	return vim.trim(line):match("^([%-%*%+])%s")
end

local function is_list_item_line(line)
	return get_line_list_marker(line) ~= nil
end

local function is_todo_item_line(line)
	if line:sub(1, 1) == "[" and line:sub(3, 3) == "]" then
		return true
	end
	return false
end

-- Try and determine list marker for similarly indented, non-blank lines
-- preceding `n`
local function get_preceding_list_marker(n)
	lines = vim.api.nvim_buf_get_lines(0, 0, n, false)
	indent = get_indent(lines[n])
	while n > 0 do
		line = lines[n]

		-- Match indent
		if indent == "" then
			if get_indent(line) ~= "" then
				goto continue
			end
		elseif line:find(indent) == 1 then
			unindented = line:sub(indent:len() + 1)
			if get_indent(unindented):find(indent) == 1 then
				goto continue
			end
		elseif line ~= "" then
			return nil
		end

		line = vim.trim(line)

		if line == "" then
			return nil
		end

		marker = get_line_list_marker(line)
		if marker ~= nil then
			return marker
		end

		::continue::
		n = n - 1
	end
end

local function toggle_todo_mark(mark)
	if mark == " " then
		return "X"
	elseif mark == "X" then
		return " "
	end
	return mark
end

local function toggle_list_item_line(line, list_marker)
	orig_line = line
	indent = get_indent(line)

	line = vim.trim(line)
	list_marker = list_marker or '-'

	if not is_list_item_line(line) then
		return indent .. list_marker .. ' ' .. line
	end

	line = line:sub(3)

	if not is_todo_item_line(line) then
		return indent .. list_marker .. ' [ ] ' .. line
	end

	todo_mark = toggle_todo_mark(line:sub(2, 2))
	line = line:sub(4)

	if todo_mark == " " or todo_mark == "X" then
		return indent .. list_marker .. ' [' .. todo_mark .. ']' .. line
	end

	return orig_line
end

local function toggle_list_item()
	set_current_line(toggle_list_item_line(get_current_line(), get_preceding_list_marker(get_line_nr())))
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
