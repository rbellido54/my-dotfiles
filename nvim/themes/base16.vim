let base16colorspace=256  " Access colors present in 256 colorspace
set termguicolors

function! s:base16_customize() abort
  call Base16hi("MatchParen", g:base16_gui05, g:base16_gui03, g:base16_cterm05, g:base16_cterm03, "bold,italic", "")
endfunction

augroup on_change_colorschema
  autocmd!
  autocmd ColorScheme * call s:base16_customize()
augroup END

let g:airline_theme = 'base16_gruvbox_dark_hard'

colorscheme base16-default-dark

