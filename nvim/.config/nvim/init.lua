vim.loader.enable()

_G.Yamano = require("yamano.utils")

require("yamano.config.options")
require("yamano.config.keymaps")
require("yamano.config.autocmds")
require("yamano.config.commands")

require("yamano.plugins")
