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
        "html-lsp",
        "htmlbeautifier",
        "htmlhint",
        "twiggy-language-server",
        "twig-cs-fixer",
        "emmet-language-server",
        "emmet-ls",
        "css-lsp",
        "prettier",
        "typescript-language-server",
      })
    end,
  },
}
