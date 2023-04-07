Prequire = function(name)
    local ok, module = pcall(require, name)
    if not ok then
        vim.notify(
            "failed to require " .. name,
            "error"
        )
        return {
            setup = function(_, _) end,
        }
    end
    return module
end
