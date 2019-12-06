command! LisToggle :call setline(".", luaeval('require("listoggle").listoggle(_A)', getline(".")))

if !exists('g:listoggle_disable_mapping')
  autocmd BufRead,BufNewFile *.md,*.mdk,*.markdown nmap <C-Space> :LisToggle<CR>
endif
