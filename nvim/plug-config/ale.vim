let g:ale_linters = {'ruby': ['standardrb']}
let g:ale_fixers = {'*': ['remove_trailing_lines', 'trim_whitespace'], 'ruby': ['standardrb'], 'go': ['gofmt']}
"
" Set this. Airline will handle the rest.
let g:airline#extensions#ale#enabled = 1
