vim.cmd [[packadd packer.nvim]]
return require('packer').startup(function(use)
  -- Packer can manage itself
  use 'wbthomason/packer.nvim'

  use {
  'nvim-telescope/telescope.nvim', tag = '0.1.6',
-- or                            , branch = '0.1.x',
  requires = { {'nvim-lua/plenary.nvim'} }
}

use({
	'rose-pine/neovim',
	as = 'rose-pine',
	config = function()
		vim.cmd('colorscheme rose-pine')
	end
})

use {
  "windwp/nvim-autopairs",
  config = function()
    local npairs = require("nvim-autopairs")
    local Rule = require("nvim-autopairs.rule")

    npairs.setup({
      check_ts = true, -- treesitter support
    })

    -- Add rule for HTML only
    npairs.add_rules({
      Rule("<", ">", "html")
    })
  end
}
use {
  "nvim-treesitter/nvim-treesitter",
  ensure_installed = { "c", "lua", "vim", "vimdoc", "query", "javascript", "typescript", "java", "rust", "html", "cpp", "xml", "css"},

  -- Install parsers synchronously (only applied to `ensure_installed`)
  sync_install = false,

  auto_install = true,

  highlight = {
    enable = true,


    additional_vim_regex_highlighting = false,
  }
}

use('theprimeagen/harpoon')
use('mbbill/undotree')
use('tpope/vim-fugitive')

end)
