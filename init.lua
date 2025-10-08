-- ########## SETTINGS ##########

-- Completion
vim.opt.completeopt = { 'menu', 'menuone', 'noselect' }

-- Encoding always utf-8
vim.opt.encoding = 'utf-8'

-- Don't make noise
vim.cmd([[set noerrorbells]])

-- Show cursorline
vim.opt.cursorline = true

-- Tab Settings
vim.opt.tabstop = 4
vim.opt.softtabstop = 4

-- Width for autoindents
vim.opt.shiftwidth = 4

-- Show Tabs
vim.opt.showtabline = 1

-- Cursor 
vim.opt.guicursor = 'a:ver25'

-- Convert Tab to whitespace
vim.opt.expandtab = true

-- Autoindent on new line
vim.opt.smartindent = true

-- Show line number
vim.opt.relativenumber = true
vim.opt.number = true

-- Don't wrap text on new line
vim.cmd([[set nowrap]])

-- Disable creating swap file
vim.cmd([[set noswapfile]])

-- Don't make Backups
vim.cmd([[set nobackup]])
vim.cmd([[set nowritebackup]])

-- Start scrolling if Cursor is n blocks away from top/bottom
vim.opt.scrolloff = 10

-- Use system clipboard
vim.cmd([[set clipboard=unnamed]])

-- Incremental search
vim.opt.incsearch = true

-- Stop highlighting if word search /WORD ends
vim.cmd([[set nohlsearch]])

-- Don't remeber last state
vim.cmd([[set viminfo=]]) 

-- Faster Completion
vim.opt.updatetime = 500

-- Column for signs
vim.opt.signcolumn = 'yes'

-- Command-line completion mode
vim.opt.wildmode = { 'list', 'longest' }

-- Statusline
vim.cmd([[set laststatus=0]]) 

-- ########## KEYMAPPINGS ##########

-- ********* VISUAL MODE **********

-- Go directly into insert mode from visual mode 
vim.keymap.set('v', 'i', '<S-i>')

-- Paste yanked text multiple times possible
vim.keymap.set('x', 'p', 'pgvy')

-- Remap C-d to change all occurences of given word to new word
vim.keymap.set('v', "<C-d>", '"+y:%s/<C-r>+//gc<left><left><left>')

-- ********* NORMAL MODE **********

-- Remap S-k Move Faster Up
vim.keymap.set('n', '<S-k>', '5k')

-- Remap S-j Move Faster Down
vim.keymap.set('n', '<S-j>', '5j')

-- Remap gb to go back to previus position
vim.keymap.set('n', 'gb', '<C-o>')

-- Remap C-o to open file in pwd
vim.keymap.set('n', '<C-o>', ':tabf ')

-- Remap space to open or close folds
vim.keymap.set('n', '<space>', 'zA')

-- Remap C-s to safe changes
vim.keymap.set('n', '<C-s>', ':w<CR>')

-- Remap C-b to switch Tabs
vim.keymap.set('n', '<C-b>', ':tabnext<CR>')

-- Remap S-C-b to switch Tabs
vim.keymap.set('n', '<S-b>', ':tabprevious<CR>')

-- remap C-n to create new Tab (File)
vim.keymap.set('n', '<C-n>', ':tabnew<CR>')

-- ########## AUTOCOMMANDS ##########

function FoldingMethod()
    filetype = vim.fn.expand('%:p'):match("^.+(%..+)$")
    filetypes = { ".sh", ".c", ".py", ".js" }
    vim.cmd([[set foldmethod=manual]])
    for n = 1, #filetypes do
        if filetypes[n] == filetype then
            vim.cmd([[set foldmethod=indent]])
        end
    end
end

local augroup = vim.api.nvim_create_augroup('Autocommands', {clear = true})
vim.api.nvim_create_autocmd('BufReadPost', {group = augroup, command = "execute 'lua FoldingMethod()'"})
vim.api.nvim_create_autocmd('CursorHold', {group = augroup, command = "execute 'lua vim.diagnostic.open_float()'" })

-- ########## CMP / LSP ##########

vim.lsp.handlers["textDocument/hover"] = vim.lsp.with(
  vim.lsp.handlers.hover, {
    border = "single"
  }
)

vim.lsp.handlers["textDocument/signatureHelp"] = vim.lsp.with(
  vim.lsp.handlers.signature_help, {
    border = "single"
  }
)

local luasnip = require('luasnip')
local cmp = require('cmp')

cmp.setup({
    snippet = { expand = function(args) require('luasnip').lsp_expand(args.body) end },
    window = { 
        completion = cmp.config.window.bordered(),
        documentation = cmp.config.window.bordered()
    },
    mapping = {     
        ["<Tab>"] = cmp.mapping(function(fallback)
            if cmp.visible() then
                cmp.select_next_item()
            elseif luasnip.expand_or_jumpable() then
                luasnip.expand_or_jhmp()
            else
                fallback()
            end
    end, { "i", "s" }),
    
 
    ["<S-Tab>"] = cmp.mapping(function(fallback)
        if cmp.visible() then
            cmp.select_prev_item()
        elseif luasnip.jumpable(-1) then
            luasnip.jump(-1)
        else
            fallback()
        end
    end, { "i", "s" }),
    
    ['<C-y>'] = cmp.config.disable,
    ['<esc>'] = cmp.mapping({ 
        i = cmp.mapping.abort(), 
        c = cmp.mapping.close()
    }),    

    ['<CR>'] = cmp.mapping.confirm({ select = false }),
    
    },
    confirm_opts = { behavior = cmp.ConfirmBehavior.Replace, select = true },
    formatting = {
        fields = { cmp.ItemField.Abbr, cmp.ItemField.Kind },
        format = function(entry, vim_item)
            vim_item.kind = ""
            vim_item.menu = ""
            return vim_item end 
    },
    completion = {
        get_trigger_characters = function(trigger_characters)
            return vim.tbl_filter(function(char)
                return char ~= ' '
            end, trigger_characters)
    end
  },
    sources = { { name = "nvim_lua" }, { name = "nvim_lsp" }, { name = "path" }, { name = "luasnip" }, { name = "buffer" } },
})

cmp.setup.cmdline('/', { mapping = cmp.mapping.preset.cmdline(), sources = { { name = 'buffer' } }  })
cmp.setup.cmdline(':', { mapping = cmp.mapping.preset.cmdline(), sources = { { name = 'cmdline' } } })

local on_attach = function(client, bufnr)
    local function buf_set_keymap(...) vim.api.nvim_buf_set_keymap(bufnr, ...) end

    local opts = { noremap=true, silent=true }
    buf_set_keymap('n', '<s-e>', '<cmd>lua vim.diagnostic.open_float()<CR>', opts)
    buf_set_keymap('n', 'gD', '<cmd>lua vim.lsp.buf.declaration()<CR>', opts)
    buf_set_keymap('n', 'gd', '<cmd>lua vim.lsp.buf.definition()<CR>', opts)
    buf_set_keymap('n', 'gh', '<cmd>lua vim.lsp.buf.hover()<CR>', opts)
    buf_set_keymap('n', 'gi', '<cmd>lua vim.lsp.buf.implementation()<CR>', opts)
    buf_set_keymap('n', '<space>D', '<cmd>lua vim.lsp.buf.type_definition()<CR>', opts)
    buf_set_keymap('n', 'gr', '<cmd>lua vim.lsp.buf.references()<CR>', opts)
end

-- ########## LSP ##########

require('lspconfig').pyright.setup{on_attach = on_attach}
require('lspconfig').clangd.setup{on_attach = on_attach}

-- ########## DIAGNOSTICS ##########

vim.diagnostic.config({ 
    virtual_text = false, 
    signs = true,
    underline = true,
    update_in_insert = false,
    severity_sort = true,
    float = { 
        focusable = false,
        style = "minimal",
        border = "rounded",
        source = "always",
        header = "",
        prefix = ""
    }
})

vim.cmd("colorscheme retrobox")

vim.api.nvim_set_hl(0, "WinSeparator", { bg = "NONE" })
vim.api.nvim_set_hl(0, "Normal", { bg = "NONE" })
