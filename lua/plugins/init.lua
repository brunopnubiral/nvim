return {
  -- Conform para formateo
  {
    "stevearc/conform.nvim",
    -- event = 'BufWritePre', -- uncomment for format on save
    config = function()
      require "configs.conform"
    end,
  },

  -- LSP config
  {
    "neovim/nvim-lspconfig",
    config = function()
      require("nvchad.configs.lspconfig").defaults()
      require "configs.lspconfig"
    end,
  },

  -- Mason para gestionar LSPs, linters y formatters
  {
    "williamboman/mason.nvim",
    opts = {
      ensure_installed = {
        "lua-language-server",
        "stylua",
        "html-lsp",
        "css-lsp",
        "prettier",
        "typescript-language-server",
        "eslint_d",
      },
    },
  },

  -- Treesitter para mejor resaltado de sintaxis
  {
    "nvim-treesitter/nvim-treesitter",
    opts = {
      ensure_installed = {
        "vim",
        "lua",
        "vimdoc",
        "html",
        "css",
        "javascript",
        "typescript",
        "tsx",
        "scss",
      },
    },
  },

  -- Nvim-cmp para autocompletado
  {
    "hrsh7th/nvim-cmp",
    config = function()
      local cmp = require 'cmp'
      cmp.setup {
        snippet = {
          expand = function(args)
            vim.fn["vsnip#anonymous"](args.body) -- For `vsnip` users.
          end,
        },
        mapping = {
          ['<C-n>'] = cmp.mapping.select_next_item({ behavior = cmp.SelectBehavior.Insert }),
          ['<C-p>'] = cmp.mapping.select_prev_item({ behavior = cmp.SelectBehavior.Insert }),
          ['<C-d>'] = cmp.mapping.scroll_docs(-4),
          ['<C-f>'] = cmp.mapping.scroll_docs(4),
          ['<C-Space>'] = cmp.mapping.complete(),
          ['<C-e>'] = cmp.mapping.close(),
          ['<CR>'] = cmp.mapping.confirm({ select = true }),
        },
        sources = {
          { name = 'nvim_lsp' },
          { name = 'vsnip' }, -- For vsnip users.
          { name = 'buffer' },
          { name = 'path' },
        }
      }
    end
  },

  -- Tema (TokyoNight con transparencia)
  {
    "folke/tokyonight.nvim",
    priority = 1000, -- Asegura que el tema se cargue primero
    config = function()
      require("tokyonight").setup({
        style = "night",
        transparent = true,
        styles = {
          sidebars = "transparent",
          floats = "transparent",
        },
      })
      vim.cmd("colorscheme tokyonight")
    end
  },

  -- nvim-transparent para transparencia mejorada
  {
    "xiyaowong/nvim-transparent",
    priority = 999, -- Se carga justo después del tema
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
      -- Aplicar transparencia después de cargar el tema
      vim.defer_fn(function()
        vim.cmd("TransparentEnable")
      end, 0)
    end
  },

  -- Telescope para buscar archivos, buffers, etc.
  {
    "nvim-telescope/telescope.nvim",
    requires = { {'nvim-lua/plenary.nvim'} }
  },

  -- GitSigns para mostrar cambios de Git en el buffer
  {
    "lewis6991/gitsigns.nvim",
    config = function()
      require('gitsigns').setup()
    end
  },

  -- Lualine para una barra de estado personalizada
  {
    "nvim-lualine/lualine.nvim",
    requires = { 'kyazdani42/nvim-web-devicons', opt = true },
    config = function()
      require('lualine').setup {
        options = {
          theme = 'tokyonight',
          component_separators = { left = '', right = ''},
          section_separators = { left = '', right = ''},
        },
        sections = {
          lualine_a = {'mode'},
          lualine_b = {'branch', 'diff', 'diagnostics'},
          lualine_c = {'filename'},
          lualine_x = {'encoding', 'fileformat', 'filetype'},
          lualine_y = {'progress'},
          lualine_z = {'location'}
        },
      }
    end
  },

  -- Dashboard para una pantalla de inicio personalizada
  {
    "glepnir/dashboard-nvim",
    config = function()
      require('dashboard').setup {
        -- configuración personalizada aquí
      }
    end
  }
}
