return {
  {
    "williamboman/mason.nvim",
    opts = function(_, opts)
      vim.list_extend(opts.ensure_installed, {
        "stylua",
        "intelephense",
        "phpactor",
        "php-cs-fixer",
        "shellcheck",
        "curlylint",
        "twigcs",
      })
    end,
  },
}
