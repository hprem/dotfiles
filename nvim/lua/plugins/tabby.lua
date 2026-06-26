local theme = {
  fill = { fg = 'NONE', bg = 'NONE' },
  head = { fg = '#8aadf4', bg = '#24273a' },
  current_tab = { fg = '#1e2030', bg = '#8aadf4' },
  tab = { fg = '#8aadf4', bg = '#24273a' },
  win = { fg = '#1e2030', bg = '#8aadf4' },
  tail = { fg = '#8aadf4', bg = '#24273a' },
}
require('tabby.tabline').set(function(line)
  -- windows list (only when > 1 window in current tab)
  local wins_section = {}
  if #line.api.get_tab_wins(line.api.get_current_tab()) > 1 then
    wins_section = line.wins_in_tab(line.api.get_current_tab()).foreach(function(win)
      return {
        line.sep('', theme.win, theme.fill),
        win.is_current() and '' or '',
        win.buf_name(),
        line.sep('', theme.win, theme.fill),
        hl = theme.win,
        margin = ' ',
      }
    end)
  end

  return {
    {
      { '   ', hl = theme.head },
      line.sep('', theme.head, theme.fill),
    },
    line.tabs().foreach(function(tab)
      local hl = tab.is_current() and theme.current_tab or theme.tab
      return {
        line.sep('', hl, theme.fill),
        tab.is_current() and '' or '',
        tab.number(),
        tab.name(),
        tab.close_btn(''),
        line.sep('', hl, theme.fill),
        hl = hl,
        margin = ' ',
      }
    end),
    line.spacer(),
    wins_section,
    {
      line.sep('', theme.tail, theme.fill),
      { '  ', hl = theme.tail },
    },
    hl = theme.fill,
  }
end)
