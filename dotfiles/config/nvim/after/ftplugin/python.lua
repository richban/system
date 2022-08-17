vim.opt.colorcolumn = "88"

vim.b.vsnip_snippet_dir = vim.fn.expand("~/.config/nvim/snippets/python/")

vim.api.nvim_buf_set_keymap(0, "n", "ga", [[<cmd>lua vim.lsp.buf.code_action()<CR>]], { noremap = true, silent = true })

vim.api.nvim_buf_set_keymap(
	0,
	"n",
	"<c-k>",
	[[<cmd>lua vim.lsp.buf.signature_help()<CR>]],
	{ noremap = true, silent = true }
)

vim.api.nvim_buf_set_keymap(0, "n", "gd", [[<cmd>lua vim.lsp.buf.definition()<CR>]], { noremap = true, silent = true })

vim.api.nvim_exec(
	[[
      function! s:PyPreSave()
        execute "silent !black " . bufname("%")
        execute "e"
      endfunction

      function! s:PyPostSave()
          execute "silent !tidy-imports --black --quiet --replace-star-imports --action REPLACE " . bufname("%")
          execute "silent !isort " . bufname("%")
          execute "e"
      endfunction

      :command! PyPreSave :call s:PyPreSave()
      :command! PyPostSave :call s:PyPostSave()

      augroup richban
          autocmd!
          autocmd bufwritepre *.py execute 'PyPreSave'
          autocmd bufwritepost *.py execute 'PyPostSave'
      augroup end
  ]],
	false
)

---- JUPYTER NOTEBOOK ---------------------------------------------------------

vim.api.nvim_exec(
	[[
    function! GetKernelFromPipenv()
        let l:kernel = tolower(system('basename $(pipenv --venv)'))
        " Remove control characters (most importantly newline)
        " echo substitute(l:kernel, '[[:cntrl:\]\]', '', 'g')
        return substitute(l:kernel, '[[:cntrl:\]\]', '', 'g')
    endfunction

    function! StartConsolePipenv(console)
        let l:flags = '--kernel ' . GetKernelFromPipenv()
        let l:command=a:console . ' ' . l:flags
        call jobstart(l:command)
    endfunction

    function! AddFilepathToSyspath()
        let l:filepath = expand('%:p:h')
        call IPyRun('import sys; sys.path.append("' . l:filepath . '")')
        echo 'Added ' . l:filepath . ' to pythons sys.path'
    endfunction

    function! ConnectToPipenvKernel()
        let l:kernel = GetKernelFromPipenv()
        " TODO: Strip the \n from the kernel name
        call IPyConnect('--existing')
    endfunction

    function! GetPoetryVenv()
        let l:poetry_config = findfile('pyproject.toml', getcwd().';')
        let l:root_path = fnamemodify(l:poetry_config, ':p:h')
        if !empty(l:poetry_config)
            let l:virtualenv_path = system('cd '.l:root_path.' && poetry env list --full-path')
            return l:virtualenv_path
        endif
    endfunction

    function! GetPipenvVenv()
        let l:pipenv_config = findfile('Pipfile', getcwd().';')
        let l:root_path = fnamemodify(l:pipenv_config, ':p:h')
        if !empty(l:pipenv_config)
            let l:virtualenv_path = system('cd '.l:root_path.' && pipenv --venv 2>/dev/null')
            return l:virtualenv_path
        endif
        return ''
    endfunction

    function! GetPythonVenv()
        let l:venv_path = GetPoetryVenv()
        if empty(l:venv_path)
            let l:venv_path = GetPipenvVenv()
        endif
        if empty(l:venv_path)
            return v:null
        else
            return l:venv_path
        endif
    endfunction

    " Starts Qt console and connect to pipenv ipykernel
    command! -nargs=0 RunQtPipenv call StartConsolePipenv('jupyter qtconsole')
    " Starts Qt console and connect to an existing ipykernel
    command! -nargs=0 RunQtConsole call jobstart("jupyter qtconsole --existing")
    " Starts pipenv ipykernel
    command! -nargs=0 RunPipenvKernel terminal /bin/bash -i -c 'pipenv run python -m ipykernel'
    command! -nargs=0 RunPoetryKernel terminal /bin/bash -i -c 'poetry run python -m ipykernel'
    " Connects nvim-ipy to the existing ipykernel (non-interactive)
    command! -nargs=0 ConnectToPipenvKernel call ConnectToPipenvKernel()
    " Connects nvim-ipy to the existing ipykernel (interactive)
    command! -nargs=0 ConnectConsole terminal /bin/bash -i -c 'jupyter console --existing'
    command! -nargs=0 AddFilepathToSyspath call AddFilepathToSyspath()
]],
	false
)
