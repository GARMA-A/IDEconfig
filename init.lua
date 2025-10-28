-- Load global settings first (leader keys, etc.)
require("config.globals")

-- Load basic vim options
require("config.options")

-- Load keymaps
require("config.keymaps")

-- Load autocommands
require("config.autocmds")

-- Bootstrap and setup lazy.nvim plugin manager
require("config.lazy")
