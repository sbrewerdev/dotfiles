# ~/.config/kitty/tab_bar.py

from __future__ import annotations

from kitty.fast_data_types import Screen, wcswidth
from kitty.tab_bar import DrawData, ExtraData, TabBarData, draw_title, as_rgb, powerline_symbols


def _rgb(x: int) -> int:
    # Convert 0xRRGGBB int to kitty Screen color encoding
    return (x << 8) | 2


def _tab_bg(draw_data: DrawData, tab: TabBarData) -> int:
    return _rgb(draw_data.tab_bg(tab))


def _tab_fg(draw_data: DrawData, tab: TabBarData) -> int:
    return _rgb(draw_data.tab_fg(tab))


def _default_bg(draw_data: DrawData) -> int:
    return _rgb(int(draw_data.default_bg))


def _default_fg(draw_data: DrawData) -> int:
    return _rgb(int(draw_data.inactive_fg))


def _draw_powerline_segment_transition(screen: Screen, prev_bg: int, next_bg: int, style: str, edge: str) -> None:
    # For 'round' kitty uses ('', '') in its own code. We'll reuse.
    sep_symbol, soft_symbol = powerline_symbols.get(style, ('', ''))
    # Draw a separator that transitions from prev_bg to next_bg
    screen.cursor.fg = prev_bg
    screen.cursor.bg = next_bg
    screen.draw(sep_symbol)


def _draw_tab_powerline(draw_data: DrawData, screen: Screen, tab: TabBarData, index: int, next_tab: TabBarData | None) -> None:
    tab_bg = _tab_bg(draw_data, tab)
    tab_fg = _tab_fg(draw_data, tab)

    default_bg = _default_bg(draw_data)

    if next_tab is not None:
        next_bg = _tab_bg(draw_data, next_tab)
        needs_soft = next_bg == tab_bg
    else:
        next_bg = default_bg
        needs_soft = False

    sep_symbol, soft_symbol = powerline_symbols.get(draw_data.powerline_style, ('', ''))

    # Kitty draws a leading space when at x==0
    if screen.cursor.x == 0:
        screen.cursor.bg = tab_bg
        screen.cursor.fg = tab_fg
        screen.draw(' ')

    # Title
    screen.cursor.bg = tab_bg
    screen.cursor.fg = tab_fg
    # font style is already handled by kitty in built-ins, but in draw_tab_bar we need to set it:
    screen.cursor.bold, screen.cursor.italic = (True, True) if tab.is_active else (False, False)
    draw_title(draw_data, screen, tab, index, 0)

    # Separator to next
    if not needs_soft:
        screen.draw(' ')
        screen.cursor.fg = tab_bg
        screen.cursor.bg = next_bg
        screen.draw(sep_symbol)
    else:
        # Soft separator
        prev_fg = screen.cursor.fg
        screen.draw(f' {soft_symbol}')
        screen.cursor.fg = prev_fg

    # trailing space (like kitty)
    if screen.cursor.x < screen.columns:
        screen.cursor.bg = next_bg
        screen.cursor.fg = tab_fg
        screen.draw(' ')


def _draw_right_label(draw_data: DrawData, screen: Screen, text: str) -> None:
    # We'll draw a small powerline-like pill on the right using active colors.
    default_bg = _default_bg(draw_data)
    bg = _rgb(int(draw_data.active_bg))
    fg = _rgb(int(draw_data.active_fg))
    sep_symbol, _soft = powerline_symbols.get(draw_data.powerline_style, ('', ''))

    label = f" {text} "
    w = wcswidth(label)
    # Need: 1 for separator + label
    needed = 1 + w

    start_x = screen.columns - needed
    if start_x <= 0:
        return

    # Only draw if it won't overwrite existing tabs
    if start_x <= screen.cursor.x:
        return

    saved = (screen.cursor.x, screen.cursor.fg, screen.cursor.bg, screen.cursor.bold, screen.cursor.italic)

    screen.cursor.x = start_x
    screen.cursor.fg = default_bg
    screen.cursor.bg = bg
    screen.draw(sep_symbol)

    screen.cursor.fg = fg
    screen.cursor.bg = bg
    screen.cursor.bold = True
    screen.draw(label)
    screen.cursor.bold = False

    (screen.cursor.x, screen.cursor.fg, screen.cursor.bg, screen.cursor.bold, screen.cursor.italic) = saved


def draw_tab_bar(screen: Screen, draw_data: DrawData, tabs: list[TabBarData], extra_data: ExtraData) -> None:
    # Clear line
    screen.cursor.x = 0
    screen.cursor.fg = _default_fg(draw_data)
    screen.cursor.bg = _default_bg(draw_data)
    screen.erase_in_line(2)

    if not tabs:
        return

    active_session = tabs[0].active_session_name  # same for all tabs
    session_tabs = [t for t in tabs if t.session_name == active_session]

    # Draw the session’s tabs
    for i, t in enumerate(session_tabs, start=1):
        next_tab = session_tabs[i] if i < len(session_tabs) else None
        _draw_tab_powerline(draw_data, screen, t, i, next_tab)

        # Stop if we run out of space
        if screen.cursor.x >= screen.columns - 1:
            break

    # Draw right-aligned session name (only if space remains)
    _draw_right_label(draw_data, screen, active_session)
