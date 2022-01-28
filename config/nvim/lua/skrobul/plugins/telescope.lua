local actions = require('telescope.actions')
require('telescope').setup{
  color_devicons = true,
    use_less = true,
    set_env = { ['COLORTERM'] = 'truecolor' },

    defaults =  {
        mappings = {
            i = {
                -- etc
                ["<esc>"] = actions.close
            }
        }
    }
}

