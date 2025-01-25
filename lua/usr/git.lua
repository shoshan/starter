local M = {}

-- Get modified lines from Git using gitsigns
local function get_git_modified_ranges()
  local gitsigns = require("gitsigns")
  local hunks = gitsigns.get_hunks()

  if not hunks then
    vim.notify("No changes detected", vim.log.levels.INFO)
    return nil
  end

  local ranges = {}

  for _, hunk in ipairs(hunks) do
    local start_line = hunk.added.start
    local end_line = start_line + hunk.added.count - 1
    table.insert(ranges, { start_line, end_line })
  end

  return ranges
end

-- Function to lint only modified lines
function M.lint_modified_lines()
  local ranges = get_git_modified_ranges()
  if not ranges then
    return
  end

  for _, range in ipairs(ranges) do
    vim.lsp.buf.lint({
      range = {
        ["start"] = { range[1], 0 }, -- Start at the beginning of the line
        ["end"] = { range[2], 0 }, -- End at the beginning of the next line
      },
    })
  end
end

-- Function to format only modified lines
function M.format_modified_lines()
  local ranges = get_git_modified_ranges()
  if not ranges then
    return
  end

  for _, range in ipairs(ranges) do
    vim.lsp.buf.format({
      range = {
        ["start"] = { range[1], 0 },
        ["end"] = { range[2], 0 },
      },
    })
  end
end

return M
