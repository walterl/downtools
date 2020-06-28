command! DownToggleListItem :lua require("downtools").toggle_list_item()
if !exists('g:downtools_disable_list_toggle_mapping')
  autocmd BufRead,BufNewFile *.md,*.mdk,*.markdown nmap <C-Space> :DownToggleListItem<CR>
endif

command! -range DownMakeLink :lua require("downtools").vlink()
if !exists('g:downtools_disable_vlink_mapping')
  autocmd BufRead,BufNewFile *.md,*.mdk,*.markdown vmap <C-k> :DownMakeLink<CR>
endif
