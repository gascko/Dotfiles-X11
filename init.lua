-- ########## SETTINGS ##########

-- Encoding always utf-8
vim.opt.encoding = 'utf-8'

-- Tab Settings
vim.opt.tabstop = 4
vim.opt.softtabstop = 4
vim.opt.showtabline = 1
vim.opt.shiftwidth = 4

-- Cursor 
vim.opt.guicursor = 'a:ver25'

-- Autoindent on new line
vim.opt.smartindent = true

-- Line Number & Cursor Line & Sign Column
vim.opt.relativenumber = true
vim.opt.cursorline = true
vim.opt.number = true
vim.opt.signcolumn = 'yes'

-- Don't wrap text
vim.wo.wrap = false

-- Start scrolling if Cursor is n blocks away from top/bottom
vim.opt.scrolloff = 10

-- Use system clipboard
vim.opt.clipboard = "unnamed"

-- Incremental search
vim.opt.incsearch = true

-- Stop highlighting if word search /WORD ends
vim.cmd([[set nohlsearch]])

-- Faster Completion
vim.opt.updatetime = 500

-- Completion
vim.opt.wildmode = { "noselect:lastused", "full" }
vim.opt.wildoptions = "pum"

-- Statusline
vim.opt.laststatus = 0

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

-- Remap C-n to create new Tab (File)
vim.keymap.set('n', '<C-n>', ':tabnew<CR>')

-- Remap C-space to open Omnicompletion
vim.keymap.set('i', '<C-Space>', '<C-x><C-o>')

-- ########## PLUGINS ##########

vim.pack.add{
  { src = 'https://github.com/neovim/nvim-lspconfig' },
}

-- ########## AUTOCOMMANDS ##########

function FoldingMethod()
    filetype = vim.fn.expand('%:p'):match("^.+(%..+)$")
    filetypes = { ".sh", ".c", ".py", ".js" }
    vim.opt.foldmethod = "manual"
    for n = 1, #filetypes do
        if filetypes[n] == filetype then
            vim.opt.foldmethod = "indent"
        end
    end
end

local augroup = vim.api.nvim_create_augroup('Autocommands', {clear = true})
vim.api.nvim_create_autocmd('BufReadPost', {group = augroup, command = "execute 'lua FoldingMethod()'"})
vim.api.nvim_create_autocmd('CursorHold', {group = augroup, command = "execute 'lua vim.diagnostic.open_float()'" })
vim.api.nvim_create_autocmd('CmdlineChanged', {group = augroup, command = 'call wildtrigger()'})

-- ########## LSP ##########

vim.lsp.config('clangd', {cmd={'clangd'}})
vim.lsp.enable('clangd')

vim.api.nvim_create_autocmd('LspAttach', {
  callback = function(ev)
    local client = vim.lsp.get_client_by_id(ev.data.client_id)
    if client and client:supports_method(vim.lsp.protocol.Methods.textDocument_completion) then
      vim.opt.completeopt = { 'menu', 'menuone', 'noinsert', 'fuzzy', 'popup' }
      vim.lsp.completion.enable(true, client.id, ev.buf, { autotrigger = true })
      vim.keymap.set('n', 'gD', function()
          vim.lsp.buf.declaration()
      end)
      vim.keymap.set('n', 'gd', function()
          vim.lsp.buf.definition()
      end)
      vim.keymap.set('n', 'gi', function()
          vim.lsp.buf.implementation()
      end)
       vim.keymap.set('n', 'gh', function()
          vim.lsp.buf.hover()
      end)
       vim.keymap.set('n', 'gr', function()
          vim.lsp.buf.references()
      end)
    end
  end,
})
-- ########## DIAGNOSTICS ##########

vim.diagnostic.config({
  virtual_lines = false
})

vim.cmd("colorscheme default")
