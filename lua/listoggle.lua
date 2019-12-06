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

local function listoggle(line)
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

return {
	listoggle = listoggle
}
