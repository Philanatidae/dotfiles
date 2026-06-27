require('phil.set')
require('phil.remap')
require('phil.filetypes')

-- Always load plugins last, we need them to override some of the keymaps
-- we made.
require('phil.lazy')
