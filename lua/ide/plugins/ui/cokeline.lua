local get_hex = require("cokeline/utils").get_hex

local str_rep = string.rep

local comments_fg = get_hex("Comment", "fg")
local errors_fg = get_hex("DiagnosticError", "fg")
local warnings_fg = get_hex("DiagnosticWarn", "fg")

local min_buffer_width = 23

local colors = require("ide.plugins.ui.colors")
vim.api.nvim_set_hl(0, "TabLineFill", { fg = colors.black, bg = colors.black })

local create_half_circle = function(text)
	return {
		text = text,
		fg = function(buffer)
			return buffer.is_focused and colors.grey1 or colors.grey0
		end,
		bg = colors.black,
		truncation = { priority = 1 },
	}
end

local components = {
	separator = {
		text = " ",
		bg = get_hex("Normal", "bg"),
		truncation = { priority = 1 },
	},

	space = {
		text = " ",
		truncation = { priority = 1 },
	},

	left_half_circle = create_half_circle(""),

	right_half_circle = create_half_circle(""),

	devicon = {
		text = function(buffer)
			return buffer.devicon.icon
		end,
		fg = function(buffer)
			return buffer.devicon.color
		end,
		truncation = { priority = 1 },
	},

	index = {
		text = function(buffer)
			return buffer.index .. ": "
		end,
		fg = function(buffer)
			return (buffer.diagnostics.errors ~= 0 and errors_fg)
				or (buffer.diagnostics.warnings ~= 0 and warnings_fg)
				or nil
		end,
		truncation = { priority = 1 },
	},

	unique_prefix = {
		text = function(buffer)
			return buffer.unique_prefix
		end,
		fg = comments_fg,
		style = "italic",
		truncation = {
			priority = 3,
			direction = "left",
		},
	},

	filename = {
		text = function(buffer)
			return buffer.filename
		end,
		fg = function(buffer)
			return ((buffer.diagnostics.errors ~= 0) and colors.red)
				or ((buffer.diagnostics.warnings ~= 0) and colors.yellow)
				or ((buffer.diagnostics.infos ~= 0) and colors.blue)
				or ((buffer.diagnostics.hints ~= 0) and colors.green)
				or (buffer.is_focused and colors.white or colors.grey3)
		end,
		style = function(buffer)
			return ((buffer.is_focused and buffer.diagnostics.errors ~= 0) and "bold,underline")
				or (buffer.is_focused and "bold")
				or (buffer.diagnostics.errors ~= 0 and "underline")
				or nil
		end,
		truncation = {
			priority = 2,
			direction = "right",
		},
	},

	diagnostics = {
		text = function(buffer)
			return (buffer.diagnostics.errors ~= 0 and "  " .. buffer.diagnostics.errors)
				or (buffer.diagnostics.warnings ~= 0 and "  " .. buffer.diagnostics.warnings)
				or (buffer.diagnostics.infos ~= 0 and "  " .. buffer.diagnostics.infos)
				or (buffer.diagnostics.hints ~= 0 and "  " .. buffer.diagnostics.hints)
				or ""
		end,
		fg = function(buffer)
			return (buffer.diagnostics.errors ~= 0 and colors.red)
				or (buffer.diagnostics.warnings ~= 0 and colors.yellow)
				or ((buffer.diagnostics.infos ~= 0) and colors.blue)
				or ((buffer.diagnostics.hints ~= 0) and colors.green)
				or nil
		end,
		truncation = { priority = 1 },
	},

	close_or_unsaved = {
		text = function(buffer)
			return buffer.is_modified and "●" or ""
		end,
		fg = function(buffer)
			return (buffer.is_modified and colors.yellow)
				or (
					((buffer.diagnostics.errors ~= 0) and colors.red)
					or ((buffer.diagnostics.warnings ~= 0) and colors.yellow)
					or ((buffer.diagnostics.infos ~= 0) and colors.blue)
					or ((buffer.diagnostics.hints ~= 0) and colors.green)
					or (buffer.is_focused and colors.white or colors.grey3)
				)
		end,
		delete_buffer_on_left_click = true,
		truncation = { priority = 1 },
	},
}

local get_remaining_space = function(buffer)
	local used_space = 0
	for _, component in pairs(components) do
		used_space = used_space
			+ vim.fn.strwidth(
				(type(component.text) == "string" and component.text)
					or (type(component.text) == "function" and component.text(buffer))
			)
	end
	return math.max(0, min_buffer_width - used_space)
end

local left_padding = {
	text = function(buffer)
		local remaining_space = get_remaining_space(buffer)
		return str_rep(" ", remaining_space / 2 + remaining_space % 2)
	end,
}

local right_padding = {
	text = function(buffer)
		local remaining_space = get_remaining_space(buffer)
		return str_rep(" ", remaining_space / 2)
	end,
}

require("cokeline").setup({
	show_if_buffers_are_at_least = 1,

	buffers = {
		-- filter_valid = function(buffer) return buffer.type ~= 'terminal' end,
		-- filter_visible = function(buffer) return buffer.type ~= 'terminal' end,
		focus_on_delete = "next",
		new_buffers_position = "next",
	},

	rendering = {
		max_buffer_width = 20,
	},

	default_hl = {
		fg = function(buffer)
			return buffer.is_focused and get_hex("Normal", "fg") or get_hex("Comment", "fg")
		end,
		bg = function(buffer)
			return buffer.is_focused and colors.grey1 or colors.grey0
		end,
	},

	sidebar = {
		filetype = "NvimTree",
		components = {
			{
				text = "  NvimTree",
				fg = colors.blue,
				bg = get_hex("NvimTreeNormal", "bg"),
				style = "bold",
			},
		},
	},

	components = {
		components.separator,
		components.left_half_circle,
		left_padding,
		components.devicon,
		-- components.index,
		components.unique_prefix,
		components.filename,
		components.diagnostics,
		components.space,
		right_padding,
		components.close_or_unsaved,
		components.right_half_circle,
	},
})
