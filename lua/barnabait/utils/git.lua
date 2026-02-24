local M = {}

local BASE_CANDIDATES = {
  "origin/master",
  "origin/main",
  "upstream/master",
  "upstream/main",
  "master",
  "main",
}

local managed_diff_windows = {}

local function trim_lines(lines)
  local out = {}
  for _, line in ipairs(lines or {}) do
    local trimmed = vim.trim(line)
    if trimmed ~= "" then
      table.insert(out, trimmed)
    end
  end
  return out
end

local function run_lines(cmd)
  local lines = vim.fn.systemlist(cmd)
  if vim.v.shell_error ~= 0 then
    local msg = (#lines > 0 and table.concat(lines, "\n")) or "command failed"
    return nil, msg
  end
  return trim_lines(lines)
end

local function resolve_base_ref()
  for _, ref in ipairs(BASE_CANDIDATES) do
    vim.fn.systemlist("git rev-parse --verify " .. ref)
    if vim.v.shell_error == 0 then
      return ref
    end
  end

  vim.fn.systemlist("git rev-parse --verify HEAD^")
  if vim.v.shell_error == 0 then
    return "HEAD^"
  end

  return nil
end

local function collect_changed_files(base)
  local files = run_lines("gh pr diff --name-only")
  if files and #files > 0 then
    return files
  end

  if not base then
    return nil, "no base branch"
  end

  return run_lines("git diff --name-only " .. base .. "...HEAD")
end

local function move_in_quickfix(delta)
  local qf = vim.fn.getqflist({ idx = 0, size = 0 })
  local size = qf.size or 0
  if size == 0 then
    vim.notify("DiffHistory: quickfix is empty.", vim.log.levels.WARN)
    return nil
  end

  local target = (qf.idx or 1) + delta
  if target < 1 or target > size then
    vim.notify("DiffHistory: no more entries.", vim.log.levels.INFO)
    return nil
  end

  return target
end

local function map_iteration_keys(bufnr)
  local opts = { buffer = bufnr, silent = true }

  vim.keymap.set("n", "]q", function()
    local idx = move_in_quickfix(1)
    if idx then
      M.open(idx)
    end
  end, opts)

  vim.keymap.set("n", "[q", function()
    local idx = move_in_quickfix(-1)
    if idx then
      M.open(idx)
    end
  end, opts)
end

local function map_quickfix_buffer(bufnr)
  map_iteration_keys(bufnr)
  vim.keymap.set("n", "<CR>", function()
    local idx = vim.fn.line(".")
    M.open(idx)
  end, { buffer = bufnr, silent = true })
end

local function close_old_diff_windows()
  for _, win in ipairs(managed_diff_windows) do
    if vim.api.nvim_win_is_valid(win) then
      pcall(vim.api.nvim_win_close, win, true)
    end
  end
  managed_diff_windows = {}
  pcall(vim.cmd, "diffoff!")
end

local function mark_current_diff_windows()
  managed_diff_windows = {}
  for _, win in ipairs(vim.api.nvim_tabpage_list_wins(0)) do
    local ok, diff_enabled = pcall(vim.api.nvim_win_get_option, win, "diff")
    if ok and diff_enabled then
      table.insert(managed_diff_windows, win)
    end
  end
end

local function open_file_and_diff(filename, base_ref)
  if not base_ref then
    vim.notify("DiffHistory: missing base reference.", vim.log.levels.WARN)
    return
  end

  close_old_diff_windows()

  if vim.bo.buftype == "quickfix" then
    vim.cmd("wincmd p")
  end

  local ok, err = pcall(vim.cmd, "edit " .. vim.fn.fnameescape(filename))
  if not ok then
    vim.notify("DiffHistory: failed to open " .. filename .. ": " .. err, vim.log.levels.ERROR)
    return
  end

  map_iteration_keys(vim.api.nvim_get_current_buf())

  local diff_ok, diff_err = pcall(vim.cmd, "Gvdiffsplit " .. base_ref)
  if not diff_ok then
    vim.notify("DiffHistory: Gvdiffsplit failed: " .. diff_err, vim.log.levels.ERROR)
    return
  end

  mark_current_diff_windows()
  map_iteration_keys(vim.api.nvim_get_current_buf())
end

function M.open(index)
  local qf = vim.fn.getqflist({ idx = 0, items = 0, context = 0 })
  local items = qf.items or {}
  if #items == 0 then
    vim.notify("DiffHistory: quickfix is empty.", vim.log.levels.WARN)
    return
  end

  local target = index or qf.idx or 1
  local entry = items[target]
  if not entry then
    vim.notify("DiffHistory: invalid quickfix entry.", vim.log.levels.WARN)
    return
  end

  local filename = entry.filename or entry.text
  if not filename or filename == "" then
    vim.notify("DiffHistory: entry missing filename.", vim.log.levels.WARN)
    return
  end

  pcall(vim.cmd, string.format("%dcc", target))
  open_file_and_diff(filename, qf.context and qf.context.base)
end

local function build_quickfix_items(files)
  local items = {}
  for _, file in ipairs(files) do
    table.insert(items, {
      filename = file,
      lnum = 1,
      col = 1,
      text = file,
    })
  end
  return items
end

local function run_diff_history()
  local base = resolve_base_ref()
  local files, err = collect_changed_files(base)
  if not files then
    vim.notify("DiffHistory: " .. (err or "failed to read diff"), vim.log.levels.ERROR)
    return
  end

  if vim.tbl_isempty(files) then
    vim.notify("DiffHistory: no changes detected.", vim.log.levels.INFO)
    return
  end

  vim.fn.setqflist({}, " ", {
    title = "DiffHistory",
    items = build_quickfix_items(files),
    context = { base = base },
  })

  vim.cmd("copen")
  map_quickfix_buffer(vim.api.nvim_get_current_buf())
  vim.cmd("wincmd p")

  M.open(1)
end

function M.setup()
  vim.api.nvim_create_user_command("DiffHistory", run_diff_history, {})
end

return M
