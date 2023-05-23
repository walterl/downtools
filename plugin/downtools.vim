command! DownToggleListItem :lua require("downtools").toggle_list_item()
if !exists('g:downtools_disable_list_toggle_mapping')
  autocmd FileType markdown nmap <C-Space> :DownToggleListItem<CR>
endif

command! -range DownMakeLink :lua require("downtools").vlink()
if !exists('g:downtools_disable_vlink_mapping')
  autocmd FileType markdown vmap <C-k> :DownMakeLink<CR>
endif

" Mapping requires tpope/vim-surround or kylechui/nvim-surround
if empty(mapcheck('S', 'v')) != 1
  if !exists('g:downtools_disable_bold_mapping')
    autocmd FileType markdown vmap <C-b> S*lvi*S*
  endif
endif
