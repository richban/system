vim.g.lightline = {
  colorscheme = 'gruvbox_material',
  active = {
    left =  {
      { 'mode', 'pastfugitive#heade' },
      { 'gitbranch', 'readonly', 'filename', 'modified' }
    },
    right = {
      { 'lineinfo' },
      { 'fileformat', 'fileencoding', 'filetype' },
      { 'lsp_status' },
    },
  },
  component = {
    lineinfo = '%3l:%-2v',
  },
  component_function = {
    gitbranch = 'fugitive#head',
  },
  component_expand = {
    lsp_status = 'LspStatus'
  },
  component_visible_condition = {
    lsp_status = 'not vim.tbl_isempty(vim.lsp.buf_get_clients(0))',
  },
  mode_map = {
    n = 'Normal',
    i = 'Insert',
    R = 'Replace',
    v = 'Visual',
    V = 'VL',
    ["<C-v>"] = 'VB',
    c = 'C',
    s = 'S',
    S = 'SL',
    ["<C-s>"] = 'SB',
    t = 'T',
  },
  -- subseparator = {
  --   left = '\\uE0B5',
    -- right = '\\uE0B7'
  -- },
  -- separator = {
  --   left = '',
  --   right = ''
  -- },
}

vim.api.nvim_exec([[
function! LspStatus() abort
  if luaeval('not vim.tbl_isempty(vim.lsp.buf_get_clients(0))')
     return luaeval("require('lsp-status').status()")
  else
     return ''
  endif
endfunction
]], true)
