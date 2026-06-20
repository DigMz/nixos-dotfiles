return {
  {
    "saghen/blink.cmp",
    opts = {
      keymap = {
        preset = "default",

        ['<Tab>'] = { 'snippet-forward', 'fallback' },
        ['S-<Tab>'] = { 'snippet-backward', 'fallback' },
      },
    },
  },
}
