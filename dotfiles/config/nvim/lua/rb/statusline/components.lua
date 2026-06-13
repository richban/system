local icons = require("rb.icons")

local git_repo_cache = {}

return {
  spaces = {
    function()
      return icons.ui.Tab .. " " .. vim.bo.shiftwidth
    end,
    padding = 1,
  },
  git_repo = {
    function()
      local bufnr = vim.api.nvim_get_current_buf()
      if git_repo_cache[bufnr] ~= nil then
        return git_repo_cache[bufnr]
      end

      local name = vim.api.nvim_buf_get_name(bufnr)
      if name == "" or vim.bo[bufnr].buftype ~= "" then
        git_repo_cache[bufnr] = ""
        return ""
      end

      local root = vim.fs.root(bufnr, ".git")
      if root then
        local repo_name = vim.fs.basename(root)
        git_repo_cache[bufnr] = repo_name
        return repo_name
      end

      git_repo_cache[bufnr] = ""
      return ""
    end,
  },
  separator = {
    function()
      return "%="
    end,
  },
  diff = {
    "diff",
    colored = false,
  },
  diagnostics = {
    "diagnostics",
    sources = { "nvim_diagnostic" },
    diagnostics_color = {
      error = "DiagnosticError",
      warn = "DiagnosticWarn",
      info = "DiagnosticInfo",
      hint = "DiagnosticHint",
    },
    colored = true,
  },
  lsp_client = {
    function(msg)
      msg = msg or ""
      local buf_clients = vim.lsp.get_clients({ bufnr = 0 })

      if next(buf_clients) == nil then
        if type(msg) == "boolean" or #msg == 0 then
          return ""
        end
        return msg
      end

      local buf_client_names = {}

      -- add client
      for _, client in pairs(buf_clients) do
        if client.name ~= "null-ls" then
          table.insert(buf_client_names, client.name)
        end
      end

      local hash = {}
      local client_names = {}
      for _, v in ipairs(buf_client_names) do
        if not hash[v] then
          client_names[#client_names + 1] = v
          hash[v] = true
        end
      end
      table.sort(client_names)
      return icons.ui.Code .. " " .. table.concat(client_names, ", ") .. " " .. icons.ui.Code
    end,
    -- icon = icons.ui.Code,
    colored = true,
    on_click = function()
      vim.cmd([[LspInfo]])
    end,
  },
}
