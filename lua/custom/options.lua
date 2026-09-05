vim.opt.relativenumber = true
vim.opt.mouse = ''
-- vim.cmd.colorscheme 'catppuccin'
vim.opt.swapfile = false
vim.opt.foldlevel = 99
vim.opt.foldlevelstart = 99
vim.opt.foldopen:remove("search")


-- ????
vim.opt.list = false
vim.opt.expandtab = true
vim.opt.tabstop = 4
vim.opt.shiftwidth = 4
vim.opt.softtabstop = 4



vim.opt.relativenumber = true
vim.opt.mouse = ''

vim.o.showbreak = '⮡ '


vim.api.nvim_create_autocmd("BufReadPost", {
    callback = function(args)
        local mark = vim.api.nvim_buf_get_mark(args.buf, '"')
        local line_count = vim.api.nvim_buf_line_count(args.buf)
        if mark[1] >0 and mark[1] <= line_count then
            vim.api.nvim_win_set_cursor(0, mark)
        end
    end
})


vim.api.nvim_create_autocmd({"WinEnter", "BufEnter"}, {
    callback = function()
        vim.opt_local.cursorline = true
    end
})

vim.api.nvim_create_autocmd({"WinLeave", "BufLeave"}, {
    -- group = "active_cursorline",
    callback = function()
        vim.opt_local.cursorline = false
    end
})

vim.opt.list = true
vim.opt.listchars:append({ trail = '▓' })
