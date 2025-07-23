return{
{ 
        'echasnovski/mini.nvim',
        version = false,
        config = function() 
                local statusline = require('mini.statusline')
                statusline.setup{ use_icons = true}
                local cursorword =  require('mini.cursorword')
                cursorword.setup{ use_icons = true}
                local notify = require('mini.notify')
                notify.setup{ use_icons = true}
                local icons = require('mini.icons')
                icons.setup{ use_icons = true}
                local animate = require('mini.animate')
                animate.setup{ use_icons = true}
       end
},
}
