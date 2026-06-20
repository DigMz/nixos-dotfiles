return {
  {
    "saghen/blink.cmp",
    opts = {
      keymap = {
        ['<Tab>'] = { 'snippet_forward', 'fallback' },
        ['S-<Tab>'] = { 'snippet_backward', 'fallback' },
        ['<CR>'] = { 'accept', 'fallback' },
      },
    },
  },
}
