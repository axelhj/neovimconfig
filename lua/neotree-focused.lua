M = {}

function M.is_neotree_focused()
    -- Get our current buffer number
    local bufnr = vim.api.nvim_get_current_buf and vim.api.nvim_get_current_buf() or vim.fn.bufnr()
    -- Get all the available sources in neo-tree
    for _, source in ipairs(require("neo-tree").config.sources) do
        -- Get each sources state
        local state = require("neo-tree.sources.manager").get_state(source)
        -- Check if the source has a state, if the state has a buffer and if the buffer is our current buffer
        if state and state.bufnr and state.bufnr == bufnr then
            return true
        end
    end
    return false
end

return M
