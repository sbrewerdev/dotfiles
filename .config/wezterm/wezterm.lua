local wezterm = require("wezterm")

local config = wezterm.config_builder()
local act = wezterm.action
local mux = wezterm.mux

-- Rounded or Square Style Tabs
local tab_style = "rounded"
local leader_prefix = utf8.char(0x1f30a) -- ocean wave

config.window_padding = { left = 0, right = 0, top = 0, bottom = 0 }

-- Sessions hint state (avoid Time comparisons)
local sessions_hint_active = false

-- Colors
config.color_scheme_dirs = { "/Users/sbrewer/.config/wezterm/colors" }
config.color_scheme = "sbrewer_theme"

config.colors = {
	background = "black",
	tab_bar = {
		background = "rgba(0,0,0,0.9)",
		inactive_tab = { bg_color = "rgba(0,0,0,0.9)", fg_color = "#666666" },
		inactive_tab_hover = { bg_color = "rgba(0,0,0,0.9)", fg_color = "#AAAAAA" },
		new_tab = { bg_color = "rgba(0,0,0,0.9)", fg_color = "#666666" },
		new_tab_hover = { bg_color = "rgba(0,0,0,0.9)", fg_color = "#AAAAAA" },
	},
}

local scheme_colors = {
	catppuccin = {
		macchiato = {
			flamingo = "#ff5e7e",
			crust = "#181926",
		},
	},
}

local colors = {
	border = scheme_colors.catppuccin.macchiato.flamingo,
	tab_bar_active_tab_fg = scheme_colors.catppuccin.macchiato.flamingo,
	tab_bar_active_tab_bg = scheme_colors.catppuccin.macchiato.crust,
	tab_bar_text = scheme_colors.catppuccin.macchiato.crust,
	arrow_foreground_leader = scheme_colors.catppuccin.macchiato.flamingo,
	arrow_background_leader = scheme_colors.catppuccin.macchiato.crust,
}

-- Window
config.window_background_opacity = 0.9
config.macos_window_background_blur = 20
config.hide_tab_bar_if_only_one_tab = false
config.use_fancy_tab_bar = false
config.tab_and_split_indices_are_zero_based = true
config.window_decorations = "RESIZE"

-- Leader
config.leader = { key = "s", mods = "CTRL" }

-- Keys
config.keys = {
	{ mods = "LEADER", key = "|", action = act.SplitHorizontal({ domain = "CurrentPaneDomain" }) },
	{ mods = "LEADER", key = "-", action = act.SplitVertical({ domain = "CurrentPaneDomain" }) },
	{ mods = "LEADER", key = "c", action = act.SpawnTab("CurrentPaneDomain") },

	{ mods = "LEADER", key = "LeftArrow", action = act.AdjustPaneSize({ "Left", 5 }) },
	{ mods = "LEADER", key = "RightArrow", action = act.AdjustPaneSize({ "Right", 5 }) },
	{ mods = "LEADER", key = "DownArrow", action = act.AdjustPaneSize({ "Down", 5 }) },
	{ mods = "LEADER", key = "UpArrow", action = act.AdjustPaneSize({ "Up", 5 }) },

	{ mods = "CTRL", key = "h", action = act.ActivatePaneDirection("Left") },
	{ mods = "CTRL", key = "j", action = act.ActivatePaneDirection("Down") },
	{ mods = "CTRL", key = "k", action = act.ActivatePaneDirection("Up") },
	{ mods = "CTRL", key = "l", action = act.ActivatePaneDirection("Right") },
}

for i = 0, 9 do
	table.insert(config.keys, {
		key = tostring(i),
		mods = "LEADER",
		action = act.ActivateTab(i),
	})
end

-- Font
config.font = wezterm.font("Anonymous Pro")

-- Monitor-aware font sizing
local last_by_window = {}

local function monitor_key(s)
	return s.description or s.name or string.format("%dx%d@%d,%d", s.width, s.height, s.x, s.y)
end

local function pick_font_for_screen(s)
	local n = (s.description or s.name or ""):lower()
	if n:find("built") then
		return 18
	end
	if n:find("ultragear") then
		return 20
	end
	if n:find("vg27aq1a") then
		return 14
	end
	if n:find("sidecar") then
		return 11.7
	end
	if n:find("u32j59") then
		return 34
	end
	if s.width >= 3840 then
		return 20
	end
	return 16
end

wezterm.on("window-focus-changed", function(window, pane)
	if not window:is_focused() then
		return
	end
	wezterm.time.call_after(0, function()
		local screens = wezterm.gui.screens()
		if not (screens and screens.active) then
			return
		end
		local active = screens.active
		local key = monitor_key(active)
		local wid = window:window_id()
		if last_by_window[wid] ~= key then
			window:set_config_overrides({ font_size = pick_font_for_screen(active) })
			last_by_window[wid] = key
		end
	end)
end)

-- Tab formatting
local function tab_title(tab_info)
	local title = tab_info.tab_title
	if title and #title > 0 then
		return title
	end
	return tab_info.active_pane.title
end

wezterm.on("format-tab-title", function(tab, tabs, panes, cfg, hover, max_width)
	local title = " " .. tab.tab_index .. ": " .. tab_title(tab) .. " "
	local left_edge_text = ""
	local right_edge_text = ""

	if tab_style == "rounded" then
		title = tab.tab_index .. ": " .. tab_title(tab)
		title = wezterm.truncate_right(title, max_width - 2)
		left_edge_text = wezterm.nerdfonts.ple_left_half_circle_thick
		right_edge_text = wezterm.nerdfonts.ple_right_half_circle_thick
	end

	if tab.is_active then
		return {
			{ Background = { Color = colors.tab_bar_active_tab_bg } },
			{ Foreground = { Color = colors.tab_bar_active_tab_fg } },
			{ Text = left_edge_text },
			{ Background = { Color = colors.tab_bar_active_tab_fg } },
			{ Foreground = { Color = colors.tab_bar_text } },
			{ Text = title },
			{ Background = { Color = colors.tab_bar_active_tab_bg } },
			{ Foreground = { Color = colors.tab_bar_active_tab_fg } },
			{ Text = right_edge_text },
		}
	end
end)

-- Status
wezterm.on("update-status", function(window, _)
	-- leader inactive
	local solid_left_arrow = ""
	local arrow_foreground = { Foreground = { Color = colors.arrow_foreground_leader } }
	local arrow_background = { Background = { Color = colors.arrow_background_leader } }
	local prefix = ""

	-- leaader is active
	if window:leader_is_active() then
		prefix = " " .. leader_prefix

		if tab_style == "rounded" then
			solid_left_arrow = wezterm.nerdfonts.ple_right_half_circle_thick
		else
			solid_left_arrow = wezterm.nerdfonts.pl_left_hard_divider
		end

		local tabs = window:mux_window():tabs_with_info()

		if tab_style ~= "rounded" then
			for _, tab_info in ipairs(tabs) do
				if tab_info.is_active and tab_info.index == 0 then
					arrow_background = { Foreground = { Color = colors.tab_bar_active_tab_fg } }
					solid_left_arrow = wezterm.nerdfonts.pl_right_hard_divider
					break
				end
			end
		end
	end

	window:set_left_status(wezterm.format({
		{ Background = { Color = colors.arrow_foreground_leader } },
		{ Text = prefix },
		arrow_foreground,
		arrow_background,
		{ Text = solid_left_arrow },
	}))
end)

return config
