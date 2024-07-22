-- Configuración base
vim.g.base46_cache = vim.fn.stdpath "data" .. "/nvchad/base46/"
vim.g.mapleader = " "

-- Bootstrap lazy.nvim
local lazypath = vim.fn.stdpath "data" .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
  local repo = "https://github.com/folke/lazy.nvim.git"
  vim.fn.system { "git", "clone", "--filter=blob:none", repo, "--branch=stable", lazypath }
end
vim.opt.rtp:prepend(lazypath)

-- Configuración de lazy.nvim
local lazy_config = require "configs.lazy"

-- Cargar plugins
require("lazy").setup({
  {
    "NvChad/NvChad",
    lazy = false,
    branch = "v2.5",
    import = "nvchad.plugins",
    config = function()
      require "options"
    end,
  },
  { import = "plugins" },
  
  -- Añadir tema blanco y moderno (GitHub theme)
  {
    "projekt0n/github-nvim-theme",
    lazy = false,
    priority = 1000,
    config = function()
      require("github-theme").setup({
        theme_style = "light",
        transparent = true,
        function_style = "italic",
        sidebars = {"qf", "vista_kind", "terminal", "packer"},
      })
      vim.cmd("colorscheme github_light")
    end
  },
  
  -- Añadir nvim-transparent
  {
    "xiyaowong/nvim-transparent",
    lazy = false,
    priority = 999,
    config = function()
      require("transparent").setup {
        enable = true,
        extra_groups = {
          "NormalFloat",
          "NvimTreeNormal",
          "TelescopeNormal",
          "WhichKeyFloat",
        },
        exclude = {},
      }
    end
  },
}, lazy_config)

-- Cargar tema
dofile(vim.g.base46_cache .. "defaults")
dofile(vim.g.base46_cache .. "statusline")

-- Cargar autocomandos de NvChad
require "nvchad.autocmds"

-- Cargar mapeos
vim.schedule(function()
  require "mappings"
end)

-- Configuración adicional para transparencia
vim.api.nvim_create_autocmd("ColorScheme", {
  pattern = "*",
  callback = function()
    local hl_groups = {
      "Normal", "SignColumn", "NormalNC", "TelescopeBorder", "NvimTreeNormal",
      "EndOfBuffer", "MsgArea"
    }
    for _, name in ipairs(hl_groups) do
      vim.cmd(string.format("highlight %s ctermbg=none guibg=none", name))
    end
  end,
})

-- Asegurar que la transparencia se aplique después de que Neovim se inicie completamente
vim.api.nvim_create_autocmd("VimEnter", {
  callback = function()
    vim.cmd("TransparentEnable")
  end,
})

-- Configuración opcional para mejorar la apariencia con transparencia
vim.opt.pumblend = 10  -- Hace que los menús emergentes sean semi-transparentes
vim.opt.winblend = 10  -- Hace que las ventanas flotantes sean semi-transparentes
