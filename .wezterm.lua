-- Pull in the wezterm API
local wezterm = require "wezterm"

local action = wezterm.action

local gui = wezterm.gui

local mux = wezterm.mux

local default_font_size = 9

local cache_dir = os.getenv("HOME") .. "/.cache/wezterm/"

local function get_window_size_cache_path(pane_exe)
  return cache_dir..pane_exe.."window_size_opt.txt"
end

-- This will hold the configuration.
local config = wezterm.config_builder()

-- This is where you actually apply your config choices

-- For example, changing the color scheme:
-- config.color_scheme = "AdventureTime"

-- Switching from default causes text and the dot of
-- i to appear sharper with Inconsolata Mono.
config.freetype_load_flags = "FORCE_AUTOHINT"

config.freetype_load_target = "Light"

config.freetype_render_target = "HorizontalLcd"

config.hide_tab_bar_if_only_one_tab = true

config.window_close_confirmation = "NeverPrompt"

config.font = wezterm.font "Inconsolata Nerd Font Mono"

config.font_size = default_font_size

config.window_padding = { left = 0, right = 0, top = 0, bottom = 0, }

config.bypass_mouse_reporting_modifiers = "CTRL"

config.adjust_window_size_when_changing_font_size = false

-- Equivalent to POSIX basename(3)
-- Given "/foo/bar" returns "bar"
-- Given "c:\\foo\\bar" returns "bar"
local function basename(s)
  return string.gsub(s, "(.*[/\\])(.*)", "%2")
end

local function get_mouse_scroll_binding_action(direction, event_unique_id)
  local event_name = "alter-font-size"..tostring(direction)..event_unique_id
  wezterm.on(event_name, function(window, pane)
    wezterm.log_info(direction > 0 and
      "Increasing font-size" or
      "Decreasing font-size"
    )
    local info = pane:get_foreground_process_info()
    local is_cmd = basename(info.executable) == "cmd.exe"
    if is_cmd then
      window:perform_action(action.ScrollByCurrentEventWheelDelta, pane)
    else -- probably is nvim.exe ie. alt-mode
      window:perform_action(direction > 0 and
        action.IncreaseFontSize or action.DecreaseFontSize,
        pane
      )
    end
  end)
  return action.EmitEvent(event_name)
end

config.mouse_bindings = {
  {
    event = { Down = { streak = 1, button = { WheelUp = 1 } } },
    mods = "NONE",
    action = get_mouse_scroll_binding_action(-1, "user_defined")
  },
  {
    event = { Down = { streak = 1, button = { WheelDown = 1 } } },
    mods = "NONE",
    action = get_mouse_scroll_binding_action(1, "user_defined")
  },
}

-- Workaround so that Nvim-mappings involving shift are possible.
config.keys = {
  {
    key = "0",
    mods = "CTRL",
    action = action.ResetFontSize
    -- action = wezterm.action_callback(function() config.font_size = default_font_size end)
  },
  {
    key = "1",
    mods = "CTRL",
    action = action.SendKey { key = "1", mods = "CTRL" },
  },
  {
    key = "2",
    mods = "CTRL",
    action = action.SendKey { key = "2", mods = "CTRL" },
  },
  {
    key = "3",
    mods = "CTRL",
    action = action.SendKey { key = "3", mods = "CTRL" },
  },
  {
    key = "4",
    mods = "CTRL",
    action = action.SendKey { key = "4", mods = "CTRL" },
  },
  {
    key = "5",
    mods = "CTRL",
    action = action.SendKey { key = "5", mods = "CTRL" },
  },
  {
    key = "6",
    mods = "CTRL",
    action = action.SendKey { key = "6", mods = "CTRL" },
  },
  {
    key = "7",
    mods = "CTRL",
    action = action.SendKey { key = "7", mods = "CTRL" },
  },
  {
    key = "8",
    mods = "CTRL",
    action = action.SendKey { key = "8", mods = "CTRL" },
  },
  {
    key = "9",
    mods = "CTRL",
    action = action.SendKey { key = "9", mods = "CTRL" },
  },
  {
    key = "l",
    mods = "CTRL",
    action = action.DisableDefaultAssignment,
  },
  -- CTRL-SHIFT-l activates the debug overlay
  { key = "l", mods = "CTRL|ALT", action = action.ShowDebugOverlay },
  {
    key = ",",
    mods = "CTRL",
    action = action.SendKey { key = ",", mods = "CTRL" },
  },
  {
    key = "i",
    mods = "CTRL|SHIFT",
    action = action.SendKey { key = "i", mods = "CTRL|SHIFT" },
  },
  {
    key = "s",
    mods = "CTRL|SHIFT",
    action = action.SendKey { key = "s", mods = "CTRL|SHIFT" },
  },
  {
    key = "w",
    mods = "CTRL|SHIFT",
    action = action.SendKey { key = "w", mods = "CTRL|SHIFT" },
  },
  {
    key = "l",
    mods = "CTRL|SHIFT",
    action = action.SendKey { key = "l", mods = "CTRL|SHIFT" },
  },
  {
    key = "h",
    mods = "CTRL|SHIFT",
    action = action.SendKey { key = "h", mods = "CTRL|SHIFT" },
  },
  {
    key = "v",
    mods = "CTRL|SHIFT",
    action = action.SendKey { key = "v", mods = "CTRL|SHIFT" },
  },
  {
    key = "c",
    mods = "CTRL|SHIFT",
    action = action.SendKey { key = "c", mods = "CTRL|SHIFT" },
  },
  {
    key = "Enter",
    mods = "SHIFT",
    action = action.SendKey { key = "Enter", mods = "SHIFT" },
  },
}

-- stat or exists does not exist inside of LUA io,
-- use workaround.
local function exists(file)
   local ok, err, code = os.rename(file, file)
   if not ok then
      if code == 13 then
         -- Permission denied, but it exists
         return true
      end
   end
   return ok, err
end

-- Restore window geometry on startup, save and restore to/from
-- $HOME/.cache/wezterm/window_size_opt.txt
wezterm.on("gui-startup", function(cmd)
  if not exists(cache_dir) then
    os.execute("mkdir " .. cache_dir)
  end
  local pane_exe = basename(cmd.args[1])
  local window_size_cache_file = io.open(
    get_window_size_cache_path(pane_exe),
    "r"
  )
  if window_size_cache_file ~= nil then
    local _, _, width, height = string.find(window_size_cache_file:read(), "(%d+),(%d+)")
    if cmd == nil then
      cmd = {width = tonumber(width), height = tonumber(height)}
    else
      cmd.width = tonumber(width)
      cmd.height = tonumber(height)
    end
    mux.spawn_window(cmd)
    window_size_cache_file:close()
  end
end)

-- Remember window geometry on startup
wezterm.on("window-resized", function(window, pane)
  local screen = gui.screens()
  local screen_width = screen.active.width
  local screen_height = screen.active.height
  local dimensions = window:get_dimensions()
  if
    dimensions.pixel_width > (screen_width * 0.9) and
    dimensions.pixel_height > (screen_height * 0.9)
  then
    return
  end
  local tab_size = pane:tab():get_size()
  local cols = tab_size["cols"]
  local rows = tab_size["rows"]
  local info = pane:get_foreground_process_info()
  local pane_exe = basename(info.executable)
  local window_size_cache_file = io.open(
    get_window_size_cache_path(pane_exe),
    "w"
  )
  if window_size_cache_file ~= nil then
    local contents = string.format("%d,%d", cols, rows)
    window_size_cache_file:write(contents)
    window_size_cache_file:close()
  end
end)

-- and finally, return the configuration to wezterm
return config
