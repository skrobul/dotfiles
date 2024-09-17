local wezterm = require("wezterm")
local config = {}
local act = wezterm.action
config.font = wezterm.font("Cascadia Code NF", { weight = "Regular", stretch = "Normal", italic = false })
config.font_size = 14.0

-- config.default_prog = { "/usr/local/bin/zsh", "-l" }
config.hide_tab_bar_if_only_one_tab = true
config.tab_max_width = 25
config.cursor_blink_rate = 800

scrollback_lines = 20000

config.inactive_pane_hsb = {
	saturation = 0.24,
	brightness = 0.5,
}

config.color_scheme = "tokyonight"
config.leader = {
	key = "b",
	mods = "CTRL",
	timeout_miliseconds = 2000,
}

local function clear_and_move(cmd)
	return act.Multiple({
		act.CopyMode("ClearPattern"),
		cmd,
	})
end
--
local function next_match(int)
	local m = act.CopyMode(int == -1 and "PriorMatch" or "NextMatch")
	return act.Multiple({ m, act.CopyMode("ClearSelectionMode") })
end
local close_copy_mode = act.Multiple({
	-- act.EmitEvent("update-status"),
	act.CopyMode("ClearSelectionMode"),
	act.CopyMode("ClearPattern"),
	act.CopyMode("Close"),
})
local copy_to = act.Multiple({ act.CopyTo("Clipboard"), act.CopyMode("ClearSelectionMode"), act.CopyMode("Close")})
local default_keys = wezterm.gui.default_key_tables()
local function extend_keys(target, source)
	local map = {}
	for i = 1, #target do
		local item = target[i]
		map[item.key] = item
	end
	for i = 1, #source do
		local item = source[i]
		local key = item.key
		if map[key] ~= nil then
			table[i] = map[key]
		else
			table.insert(target, source[i])
		end
	end
	return target
end

local function complete_search(should_clear)
    return wezterm.action_callback(function(window, pane, _)
        if should_clear then
            window:perform_action(act.CopyMode('ClearPattern'), pane)
        end
        window:perform_action(act.CopyMode('AcceptPattern'), pane)
        window:perform_action(act.EmitEvent('update-status'), pane)

        -- For some reason this just does not work unless we retry a few times.
        -- Probably something to do with state management between Search/Copy mode.
        for _ = 1, 3, 1 do
            wezterm.sleep_ms(100)
            window:perform_action(act.CopyMode('ClearSelectionMode'), pane)
        end
    end)
end

local search = act.Multiple({
	act.CopyMode("ClearPattern"),
	act.EmitEvent("update-status"),
	act.Search({ CaseSensitiveString = "" }),
})
config.keys = {
	{
		key = ",",
		mods = "LEADER",
		action = act.PromptInputLine({
			action = { EmitEvent = "user-defined-2" },
			description = "Enter\u{20}new\u{20}name\u{20}for\u{20}tab",
		}),
	},
	{ key = ";", mods = "LEADER", action = act.ActivatePaneDirection("Prev") },
	{
		key = "E",
		mods = "CTRL",
		action = act.PromptInputLine({
			action = { EmitEvent = "user-defined-0" },
			description = "Enter\u{20}new\u{20}name\u{20}for\u{20}tab",
		}),
	},
	{
		key = "R",
		mods = "ALT|CTRL",
		action = act.PromptInputLine({
			action = { EmitEvent = "user-defined-1" },
			description = "Enter\u{20}new\u{20}name\u{20}for\u{20}tab",
		}),
	},
	{ key = "w", mods = "LEADER", action = act.ShowTabNavigator },
	{ key = "z", mods = "LEADER", action = act.TogglePaneZoomState },
	{ key = ";", mods = "LEADER", action = act.ActivatePaneDirection("Prev") },
	{ key = "n", mods = "LEADER", action = act.ActivateTabRelative(1) },
	{ key = "o", mods = "LEADER", action = act.ActivatePaneDirection("Next") },
	{ key = "p", mods = "LEADER", action = act.ActivateTabRelative(-1) },
}
config.key_tables = {
	copy_mode = extend_keys(default_keys.copy_mode, {
		{ key = "c", mods = "CTRL", action = close_copy_mode },
		{ key = "q", mods = "NONE", action = close_copy_mode },
		{ key = "Escape", mods = "NONE", action = close_copy_mode },
		{ key = "Space", mods = "CTRL", action = act.CopyMode("ClearPattern") },
		{ key = "y", mods = "NONE", action = copy_to },

		{ key = "h", mods = "NONE", action = act.CopyMode("MoveLeft") },
		{ key = "j", mods = "NONE", action = act.CopyMode("MoveDown") },
		{ key = "k", mods = "NONE", action = act.CopyMode("MoveUp") },
		{ key = "l", mods = "NONE", action = act.CopyMode("MoveRight") },
		{ key = "/", mods = "NONE", action = search },
		{ key = "?", mods = "SHIFT", action = search },
		{ key = "p", mods = "CTRL", action = next_match(-1) },
		{ key = "n", mods = "CTRL", action = next_match(1) },
		{ key = "n", mods = "NONE", action = next_match(1) },
		{ key = "N", mods = "NONE", action = next_match(-1) },
		{
			key = "s",
			mods = "NONE",
			action = act.Multiple({
				{ CopyTo = "PrimarySelection" },
				{ CopyMode = "Close" },
				{ PasteFrom = "PrimarySelection" },
			}),
		},
    -- uppercased vim motions
		{ key = "B", mods = "NONE", action = act.CopyMode("MoveBackwardWord") },
		{ key = "E", mods = "NONE", action = act.CopyMode("MoveForwardWordEnd") },
		{ key = "W", mods = "NONE", action = act.CopyMode("MoveForwardWord") },
	}),
	search_mode = extend_keys(default_keys.search_mode, {
		{ key = "Escape", mods = "NONE", action = complete_search(true) },
		{ key = "Enter", mods = "NONE", action = complete_search(false) },
		{ key = "r", mods = "CTRL", action = act.CopyMode("CycleMatchType") },
	}),
}

local smart_splits = wezterm.plugin.require("https://github.com/mrjones2014/smart-splits.nvim")
-- -- you can put the rest of your Wezterm config here
smart_splits.apply_to_config(config)

return config
