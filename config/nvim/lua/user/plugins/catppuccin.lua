return {
  "catppuccin/nvim",
  name = "catppuccin",
  opts = {
    flavor = "macchiato",
    transparent_background = false,
    dim_inactive = {
      -- dims the background color of inactive window
      enabled = false, -- currently disabled; breaks transparency
      shade = "dark",
      percentage = 0.15, -- percentage of the shade to apply to the inactive window
    },
    custom_highlights = function(colors)
      return {
        -- See :help highlight-groups and https://neovim.io/doc/user/syntax.html#highlight-groups

        -- without setting bg on normalfloat windows will have transparent bg
        -- which looks a little confusing to me
        NormalFloat = { bg = colors.mantle },
        FloatBorder = { bg = colors.mantle },

        -- Comment = { bg = colors.surface0 },
      }
    end,
    integrations = {
      which_key = true,
      lsp_trouble = true,
      mason = true,
      barbar = true,
    }
  },
  config = function ()
    -- vim.cmd([[colorscheme catppuccin]])
  end,
}