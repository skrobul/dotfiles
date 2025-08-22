local wezterm = require("wezterm")
local config = {}
local act = wezterm.action
config.font = wezterm.font("JetBrains Mono NF", { weight = "Medium", stretch = "Normal", italic = false })
config.font_size = 14.0
config.enable_wayland = false

local resurrect = wezterm.plugin.require("https://github.com/MLFlexer/resurrect.wezterm")

resurrect.set_encryption({
	enable = true,
	method = "gpg", -- "age" is the default encryption method, but you can also specify "rage" or "gpg"
	public_key = "8D921D0CB9A85565",
})
resurrect.set_max_nlines(3000) -- Or even lower if needed

-- ressurect toasts
local resurrect_event_listeners = {
	"resurrect.error",
	"resurrect.save_state.finished",
}
local is_periodic_save = false
wezterm.on("resurrect.periodic_save", function()
	is_periodic_save = true
end)
for _, event in ipairs(resurrect_event_listeners) do
	wezterm.on(event, function(...)
		if event == "resurrect.save_state.finished" and is_periodic_save then
			is_periodic_save = false
			return
		end
		local args = { ... }
		local msg = event
		for _, v in ipairs(args) do
			msg = msg .. " " .. tostring(v)
		end
		wezterm.gui.gui_windows()[1]:toast_notification("Wezterm - resurrect", msg, nil, 10000)
	end)
end

-- config.default_prog = { "/usr/local/bin/zsh", "-l" }
config.hide_tab_bar_if_only_one_tab = true
config.tab_max_width = 25
config.cursor_blink_rate = 800

config.scrollback_lines = 20000

config.inactive_pane_hsb = {
	saturation = 0.24,
	brightness = 0.5,
}

config.color_scheme = "Rosé Pine (Gogh)"
config.leader = {
	key = "b",
	mods = "CTRL",
	timeout_miliseconds = 2000,
}

local function next_match(int)
	local m = act.CopyMode(int == -1 and "PriorMatch" or "NextMatch")
	return act.Multiple({ m, act.CopyMode("ClearSelectionMode") })
end

local close_copy_mode = act.Multiple({
	act.CopyMode("ClearSelectionMode"),
	act.CopyMode("ClearPattern"),
	act.CopyMode("Close"),
})
local copy_to = act.Multiple({ act.CopyTo("Clipboard"), act.CopyMode("ClearSelectionMode"), act.CopyMode("Close") })
local default_keys = wezterm.gui.default_key_tables()

-- allows to reuse default wezterm mappings without having to define everything
-- from scratch
local function merge_key_table(defaults, customs)
	local customs_map = {}
	-- Add your custom keys to a map for quick lookup
	for _, item in ipairs(customs) do
		customs_map[item.key .. item.mods] = item
	end

	local final_table = {}
	-- Add the defaults only if they aren't in your custom list
	for _, item in ipairs(defaults) do
		if not customs_map[item.key .. item.mods] then
			table.insert(final_table, item)
		end
	end

	-- Add all of your custom keys
	for _, item in ipairs(customs) do
		table.insert(final_table, item)
	end

	return final_table
end

local function complete_search(should_clear)
	return wezterm.action_callback(function(window, pane, _)
		if should_clear then
			window:perform_action(act.CopyMode("ClearPattern"), pane)
		end
		window:perform_action(act.CopyMode("AcceptPattern"), pane)
		window:perform_action(act.EmitEvent("update-status"), pane)

		-- For some reason this just does not work unless we retry a few times.
		-- Probably something to do with state management between Search/Copy mode.
		for _ = 1, 3, 1 do
			wezterm.sleep_ms(100)
			window:perform_action(act.CopyMode("ClearSelectionMode"), pane)
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
			action = wezterm.action_callback(function(window, pane, line)
				-- line will be `nil` if they hit escape without entering anything
				-- An empty string if they just hit enter
				-- Or the actual line of text they wrote
				if line then
					window:active_tab():set_title(line)
				end
			end),
			description = "Enter\u{20}new\u{20}name\u{20}for\u{20}tab",
		}),
	},
	{ key = ";", mods = "LEADER", action = act.ActivatePaneDirection("Prev") },
	{ key = "t", mods = "LEADER", action = act.ShowTabNavigator },
	{ key = "z", mods = "LEADER", action = act.TogglePaneZoomState },
	{ key = "n", mods = "LEADER", action = act.ActivateTabRelative(1) },
	{ key = "o", mods = "LEADER", action = act.ActivatePaneDirection("Next") },
	{ key = "p", mods = "LEADER", action = act.ActivateTabRelative(-1) },
	{ key = "[", mods = "LEADER", action = act.ActivateCopyMode },

	-- focusing
	{ key = "1", mods = "LEADER", action = act.ActivateTab(0) },
	{ key = "2", mods = "LEADER", action = act.ActivateTab(1) },
	{ key = "3", mods = "LEADER", action = act.ActivateTab(2) },
	{ key = "4", mods = "LEADER", action = act.ActivateTab(3) },
	{ key = "5", mods = "LEADER", action = act.ActivateTab(4) },
	{ key = "6", mods = "LEADER", action = act.ActivateTab(5) },
	{ key = "7", mods = "LEADER", action = act.ActivateTab(6) },
	{ key = "8", mods = "LEADER", action = act.ActivateTab(7) },
	{ key = "9", mods = "LEADER", action = act.ActivateTab(8) },

	-- pane rotation
	{
		mods = "LEADER",
		key = "Space",
		action = wezterm.action.RotatePanes("Clockwise"),
	},
	-- show the pane selection mode, but have it swap the active and selected panes
	{
		mods = "LEADER",
		key = "0",
		action = wezterm.action.PaneSelect({
			mode = "SwapWithActive",
		}),
	},

	-- extra bindings for easier splits without Alt
	{
		mods = "CTRL|SHIFT",
		key = "%",
		action = wezterm.action.SplitHorizontal({ domain = "CurrentPaneDomain" }),
	},
	{
		mods = "CTRL|SHIFT",
		key = '"',
		action = wezterm.action.SplitVertical({ domain = "CurrentPaneDomain" }),
	},

	-- muscle memory ctrl+shift+s immediate copy&paste
	{
		key = "S",
		mods = "CTRL|SHIFT",
		action = wezterm.action.PasteFrom("PrimarySelection"),
	},
	-- pass-through ctrl+b
	{
		key = "b",
		mods = "CTRL|LEADER",
		repeat_times = 2,
		action = wezterm.action.SendKey({ key = "b", mods = "CTRL" }),
	},

	-- mux
	--
	-- -- Attach to muxer
	{
		key = "a",
		mods = "LEADER",
		action = act.AttachDomain("unix"),
	},

	-- Detach from muxer
	{
		key = "d",
		mods = "LEADER",
		action = act.DetachDomain({ DomainName = "unix" }),
	},
	{
		key = "$",
		mods = "LEADER|SHIFT",
		action = act.PromptInputLine({
			description = "Enter new name for workspace",
			action = wezterm.action_callback(function(window, pane, line)
				if line then
					wezterm.mux.rename_workspace(wezterm.mux.get_active_workspace(), line)
					resurrect.save_state(resurrect.workspace_state.get_workspace_state())
				end
			end),
		}),
	},
	-- Show list of workspaces
	{
		key = "q",
		mods = "LEADER",
		action = act.ShowLauncherArgs({ flags = "WORKSPACES" }),
	},
	-- ressurect keys
	{
		key = "w", -- save whole workspace
		mods = "LEADER",
		action = wezterm.action_callback(function(win, pane)
			resurrect.save_state(resurrect.workspace_state.get_workspace_state())
		end),
	},
	{
		key = "W", -- save single window
		mods = "LEADER|SHIFT",
		action = resurrect.window_state.save_window_action(),
	},
	{
		key = "s",
		mods = "LEADER",
		action = wezterm.action_callback(function(win, pane)
			resurrect.save_state(resurrect.workspace_state.get_workspace_state())
			resurrect.window_state.save_window_action()
		end),
	},
	-- fuzzy load a state (workspace or window)
	{
		key = "l",
		mods = "LEADER",
		action = wezterm.action_callback(function(win, pane)
			resurrect.fuzzy_load(win, pane, function(id, label)
				local type = string.match(id, "^([^/]+)") -- match before '/'
				id = string.match(id, "([^/]+)$") -- match after '/'
				id = string.match(id, "(.+)%..+$") -- remove file extension
				local state
				if type == "workspace" then
					state = resurrect.load_state(id, "workspace")
					resurrect.workspace_state.restore_workspace(state, {
						relative = true,
						restore_text = true,
						on_pane_restore = resurrect.tab_state.default_on_pane_restore,
					})
				elseif type == "window" then
					state = resurrect.load_state(id, "window")
					resurrect.window_state.restore_window(pane:window(), state, {
						relative = true,
						restore_text = true,
						on_pane_restore = resurrect.tab_state.default_on_pane_restore,
						-- uncomment this line to use active tab when restoring
						-- tab = win:active_tab(),
					})
				end
			end)
		end),
	},
	-- delete a state
	{
		key = "D",
		mods = "LEADER",
		action = wezterm.action_callback(function(win, pane)
			resurrect.fuzzy_load(win, pane, function(id)
				resurrect.delete_state(id)
			end, {
				title = "Delete State",
				description = "Select State to Delete and press Enter = accept, Esc = cancel, / = filter",
				fuzzy_description = "Search State to Delete: ",
				is_fuzzy = true,
			})
		end),
	},
}
config.key_tables = {
	copy_mode = merge_key_table(default_keys.copy_mode, {
		-- close copy mode
		{ key = "c", mods = "CTRL", action = close_copy_mode },
		{ key = "q", mods = "NONE", action = close_copy_mode },
		{ key = "Escape", mods = "NONE", action = close_copy_mode },
		-- clear pattern
		{ key = "Space", mods = "CTRL", action = act.CopyMode("ClearPattern") },

		-- accept selection and copy
		{ key = "Enter", mods = "NONE", action = copy_to },
		{ key = "y", mods = "NONE", action = copy_to },

		-- navigation
		{ key = "h", mods = "NONE", action = act.CopyMode("MoveLeft") },
		{ key = "j", mods = "NONE", action = act.CopyMode("MoveDown") },
		{ key = "k", mods = "NONE", action = act.CopyMode("MoveUp") },
		{ key = "l", mods = "NONE", action = act.CopyMode("MoveRight") },
		{ key = "/", mods = "NONE", action = search },
		{ key = "?", mods = "SHIFT", action = search },
		{ key = "n", mods = "NONE", action = next_match(1) },
		{ key = "N", mods = "NONE", action = next_match(-1) },

		-- copy and paste immediately
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
	search_mode = merge_key_table(default_keys.search_mode, {
		{ key = "Escape", mods = "NONE", action = complete_search(true) },
		{ key = "Enter", mods = "NONE", action = complete_search(false) },
		-- case sensitive, insensitive, regex
		{ key = "r", mods = "CTRL", action = act.CopyMode("CycleMatchType") },
	}),
}

local smart_splits = wezterm.plugin.require("https://github.com/mrjones2014/smart-splits.nvim")
-- -- you can put the rest of your Wezterm config here
smart_splits.apply_to_config(config)

-- sessions
config.unix_domains = {
	{
		name = "unix",
	},
}

-- This causes `wezterm` to act as though it was started as
-- `wezterm connect unix` by default, connecting to the unix
-- domain on startup.
-- If you prefer to connect manually, leave out this line.
-- config.default_gui_startup_args = { 'connect', 'unix' }
--

wezterm.on("augment-command-palette", function(window, pane)
	local workspace_state = resurrect.workspace_state
	return {
		-- {
		-- 	brief = "Window | Workspace: Switch Workspace",
		-- 	icon = "md_briefcase_arrow_up_down",
		-- 	action = workspace_switcher.switch_workspace(),
		-- },
		{
			brief = "Window | Workspace: Rename Workspace",
			icon = "md_briefcase_edit",
			action = wezterm.action.PromptInputLine({
				description = "Enter new name for workspace",
				action = wezterm.action_callback(function(window, pane, line)
					if line then
						wezterm.mux.rename_workspace(wezterm.mux.get_active_workspace(), line)
						resurrect.save_state(workspace_state.get_workspace_state())
					end
				end),
			}),
		},
	}
end)

return config
