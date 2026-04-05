return {
  'nvim-tree/nvim-web-devicons',
  lazy = false, -- make sure it's loaded early
  config = function()
    require('nvim-web-devicons').setup { default = true }
  end
}
