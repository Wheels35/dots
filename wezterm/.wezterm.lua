local wezterm = require 'wezterm'
local config = wezterm.config_builder()

-- The filled in variant of the < symbol
local SOLID_RIGHT_ARROW = wezterm.nerdfonts.ple_right_half_circle_thick

-- The filled in variant of the > symbol
local SOLID_LEFT_ARROW = wezterm.nerdfonts.ple_left_half_circle_thick

-- Your existing config settings
config.color_scheme = 'Catppuccin Mocha'
config.font_size = 16
config.default_cursor_style = 'BlinkingBar'
config.window_decorations = "INTEGRATED_BUTTONS|RESIZE"

-- This function returns the suggested title for a tab.
-- It prefers the title that was set via `tab:set_title()`
-- or `wezterm cli set-tab-title`, but falls back to the
-- title of the active pane in that tab.
function tab_title(tab_info)
  local title = tab_info.tab_title
  -- if the tab title is explicitly set, take that
  if title and #title > 0 then
    return title
  end
  -- Otherwise, use the title from the active pane
  -- in that tab
  return tab_info.active_pane.title
end

wezterm.on(
  'format-tab-title',
  function(tab, tabs, panes, config, hover, max_width)
    -- Get the current color scheme's resolved colors
    local scheme = wezterm.color.get_builtin_schemes()[config.color_scheme]
    
    -- Use the color scheme's tab_bar colors if available, otherwise use reasonable defaults
    local edge_background = scheme.background -- or "#11111b"
    local background = scheme.tab_bar and scheme.tab_bar.inactive_tab.bg_color -- or "#181825"
    local foreground = scheme.tab_bar and scheme.tab_bar.inactive_tab.fg_color -- or "#cdd6f4"

    if tab.is_active then
      background = scheme.tab_bar and scheme.tab_bar.active_tab.bg_color -- or "#cba6f7"
      foreground = scheme.tab_bar and scheme.tab_bar.active_tab.fg_color -- or "#11111b"
    elseif hover then
      background = scheme.tab_bar and scheme.tab_bar.inactive_tab_hover.bg_color -- or "#1e1e2e"
      foreground = scheme.tab_bar and scheme.tab_bar.inactive_tab_hover.fg_color -- or "#cdd6f4"
    end

    local edge_foreground = background

    local title = tab_title(tab)

    -- ensure that the titles fit in the available space,
    -- and that we have room for the edges.
    title = wezterm.truncate_right(title, max_width - 2)

    return {
      { Background = { Color = edge_background } },
      { Foreground = { Color = edge_foreground } },
      { Text = SOLID_LEFT_ARROW },
      { Background = { Color = background } },
      { Foreground = { Color = foreground } },
      { Text = title },
      { Background = { Color = edge_background } },
      { Foreground = { Color = edge_foreground } },
      { Text = SOLID_RIGHT_ARROW },
    }
  end
)

return config
