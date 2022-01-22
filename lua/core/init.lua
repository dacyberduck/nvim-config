local async_core = vim.loop.new_async(
  vim.schedule_wrap(
    function()
      pcall(require,'core.options')
      pcall(require,'core.mappings')
      pcall(require,'core.autocmds')
    end
  )
)

async_core:send()
