return {
  {
    "saghen/blink.cmp",
    opts = {
      keymap = {
        preset = "default",

        ['<Tab>'] = { 'snippet_forward', 'fallback' },
        ['S-<Tab>'] = { 'snippet_backward', 'fallback' },
        ['<CR>'] = { 'accept', 'fallback' },
      },
    },
  },
}
