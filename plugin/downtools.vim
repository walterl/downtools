command! LisToggle :call setline(".", luaeval('require("downtools").listoggle(_A)', getline(".")))
if !exists('g:downtools_disable_list_toggle_mapping')
  autocmd BufRead,BufNewFile *.md,*.mdk,*.markdown nmap <C-Space> :LisToggle<CR>
endif

command! -range MakeMarkdownLink :lua require("downtools").vlink()
if !exists('g:downtools_disable_vlink_mapping')
  autocmd BufRead,BufNewFile *.md,*.mdk,*.markdown vmap <C-k> :MakeMarkdownLink<CR>
endif
