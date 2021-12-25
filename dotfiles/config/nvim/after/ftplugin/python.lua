vim.opt.colorcolumn = "88"

---- JUPYTEXT -----------------------------------------------------------------
vim.g.jupytext_fmt = 'py'
vim.g.jupytext_style = 'hydrogen'

---- JUPYTER ASCENDING --------------------------------------------------------

vim.cmd [[ nnoremap <silent><c-x> <Plug>JupyterExecute ]]
vim.cmd [[ nnoremap <silent><c-X> <Plug>JupyterExecuteAll ]]

---- NVIM-IPY -----------------------------------------------------------------

vim.g.nvim_ipy_perform_mappings = 0
vim.g.ipy_celldef = '# %%'

vim.cmd [[map <silent><c-s> <Plug>(IPy-Run)]]
vim.cmd [[map <leader>rc <Plug>(IPy-RunCell)]]

---- IRON-REPL ----------------------------------------------------------------

local iron = require('iron')

iron.core.add_repl_definitions {python = {venv_python = {command = "pipenv run ipython"}}}

iron.core.set_config {preferred = {python = "venv_python"}}

-- vim.cmd [[nnoremap <silent><c-v> <Plug>(iron-visual-send)]]
-- vim.cmd [[nnoremap <C-l> <Plug>(iron-send-line)]]

-- " Send cell to IronRepl and move to next cell.
vim.cmd [[nmap ]x ctrih/^# %%<CR><CR>]]
vim.cmd [[nmap [x ctrah/^# %%<CR><CR>]]

---- JUPYTER NOTEBOOK ---------------------------------------------------------

vim.api.nvim_exec([[
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
]], false)
