addEventListener(
  'set to javascript.jsx',
  { 'BufNewFile,BufRead *.jsx' },
  function() vim.cmd('set filetype=javascript.jsx') end
)

addEventListener(
  'set to typescript.tsx',
  { 'BufNewFile,BufRead *.tsx' },
  function() vim.cmd('set filetype=typescript.tsx') end
)

addEventListener(
  'Markdown preview',
  { 'BufNew,BufEnter *.md,*.markdown,*.wiki' },
  function() vim.cmd('set conceallevel=0') end
)

addEventListener(
  'IndentLines',
  { 'BufNew,BufEnter *.html,*.css' },
  function() vim.cmd('execute "IndentLinesToggle"') end
)

addEventListener('LuaHighlight', { 'TextYankPost *' }, function()
  require'vim.highlight'.on_yank() end
)

addEventListener('update lightline when lsp diagnostics is updated',
  { 'User LspDiagnosticsChanged', 'User LspMessageUpdate', 'User LspStatusUpdate' },
  function () vim.cmd('call lightline#update()') end
)

addEventListener('Let Vista run explicitly',
  { 'VimEnter *' },
  function () vim.cmd('call vista#RunForNearestMethodOrFunction()') end
)

addEventListener('TrimWhiteSpace',
  { 'BufWritePre *' },
  function () vim.cmd('call TrimWhitespace()') end
)
