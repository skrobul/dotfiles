### OPTIONS
# 
# 'black'
# 'dark red'
# 'dark green'
# 'brown'
# 'dark blue'
# 'dark magenta'
# 'dark cyan'
# 'light gray'
# 'dark gray'
# 'light red'
# 'light green'
# 'yellow'
# 'light blue'
# 'light magenta'
# 'light cyan'
# 'white'

# (16fg, 16bg, style, 256fg, 256bg)

theme = [
    ('list-header', '', '', '', '', ''),
    ('list-header-column', 'black', 'dark gray', '', 'black', 'g52'),
    ('list-header-column-separator', 'black', 'light gray', '', 'black', 'g52'),
    ('striped-table-row', 'white', 'dark red', '', 'g85', 'g11'),
    ('reveal focus', 'black', 'dark cyan', '', 'white', '#06f'), # cursor
    ('message status', 'white', 'dark blue', 'standout', 'white', 'dark blue'),
    ('message error', 'white', 'dark red', 'standout', 'white', 'dark red'),
    ('status', 'dark magenta', 'black', '', '#0af', 'g17'),
    ('flash off', 'black', 'black', 'standout', 'black', 'black'),
    ('flash on', 'white', 'black', 'standout', 'white', 'black'),
    ('pop_up', 'white', 'black', '', 'white', 'black'),
    ('button action', 'white', 'light red', '', 'white', 'light red'),
    ('button cancel', 'black', 'light gray', '', 'black', 'light gray'),
]
