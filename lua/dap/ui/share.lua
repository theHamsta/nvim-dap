local api = vim.api

local M = {}


function M.apply_winopts(win, opts)
  if not opts then return end
  assert(
    type(opts) == 'table',
    'winopts must be a table, not ' .. type(opts) .. ': ' .. vim.inspect(opts)
  )
  for k, v in pairs(opts) do
    if k == 'width' then
      api.nvim_win_set_width(win, v)
    elseif k == 'height' then
      api.nvim_win_set_height(win, v)
    else
      api.nvim_win_set_option(win, k, v)
    end
  end
end


function M.pick_one(items, prompt, label_fn)
  if not items or #items == 0 then
    return nil
  end
  if #items == 1 then
    return items[1]
  end
  local choices = {prompt}
  for i, item in ipairs(items) do
    table.insert(choices, string.format('%d: %s', i, label_fn(item)))
  end
  local choice = vim.fn.inputlist(choices)
  if choice < 1 or choice > #items then
    return nil
  end
  return items[choice]
end


return M
