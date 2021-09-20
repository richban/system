require'compe'.setup {
  enabled = true,
  debug = true,
  min_length = 2,
  -- enabled = true,
  -- autocomplete = true,
  -- debug = false,
  -- min_length = 1,
  -- preselect = "enable",
  -- throttle_time = 200,
  -- source_timeout = 200,
  -- incomplete_delay = 400,
  -- allow_prefix_unmatch = false,

  source = {
    vsnip = {
      filetypes = {'markdown', 'json', 'yaml', 'css', 'scss', 'javascript', 'typescript', 'javascriptreact', 'typescriptreact', 'typescript.tsx'},
      sticky_char = '0'
    },
    nvim_lua = { 'lua' },
    nvim_lsp = {
      filetypes = {'markdown', 'json', 'yaml', 'css', 'scss', 'javascript', 'typescript', 'javascriptreact', 'typescriptreact' ,'typescript.tsx'}
    },
    path = true,
    buffer =  true,
  },
  -- enabled = true,
  -- autocomplete = true,
  -- debug = false,
  -- min_length = 1,
  -- preselect = "enable",
  -- throttle_time = 80,
  -- source_timeout = 200,
  -- resolve_timeout = 800,
  -- incomplete_delay = 400,
  -- max_abbr_width = 100,
  -- max_kind_width = 100,
  -- max_menu_width = 100,
  -- documentation = {
  --   border = { "", "", "", " ", "", "", "", " " }, -- the border option is the same as `|help nvim_open_win|`
  --   winhighlight = "NormalFloat:CompeDocumentation,FloatBorder:CompeDocumentationBorder",
  --   max_width = 120,
  --   min_width = 60,
  --   max_height = math.floor(vim.o.lines * 0.3),
  --   min_height = 1,
  -- },
  -- source = {
  --   path = true,
  --   buffer = true,
  --   calc = true,
  --   nvim_lsp = true,
  --   nvim_lua = true,
  --   vsnip = true,
  --   luasnip = true,
  -- },
}
