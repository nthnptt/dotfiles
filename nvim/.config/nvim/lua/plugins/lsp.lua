return {
  {
    "williamboman/mason.nvim",
    opts = function(_, opts)
      vim.list_extend(opts.ensure_installed, {
        "stylua",
        "intelephense",
        "psalm",
        "php-cs-fixer",
        "shellcheck",
        "curlylint",
        "twigcs",
      })
    end,
  },
}
