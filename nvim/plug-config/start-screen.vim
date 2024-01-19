" Let startify keep our sessions
let g:startify_session_dir = '~/.config/nvim/session'

" Menu list
let g:startify_lists = [
          \ { 'type': 'files',     'header': ['   Files']            },
          \ { 'type': 'dir',       'header': ['   Current Directory '. getcwd()] },
          \ { 'type': 'sessions',  'header': ['   Sessions']       },
          \ { 'type': 'bookmarks', 'header': ['   Bookmarks']      },
          \ ]

" bookmarks
let g:startify_bookmarks = [
            \ { 'p': '~/development' },
            \ { 'o': '~/development/orders' },
            \ { 'i': '~/.config/nvim/init.vim' },
            \ { 'z': '~/.zshrc' },
            \ ]

" Automatically restart a session
let g:startify_session_autoload = 1

" take care of buffers
let g:startify_session_delete_buffers = 1

" vim-rooter like
let g:startify_change_to_vcs_root = 1

" automatically update sessions
let g:startify_session_persistence = 1

" get rid of empty buffer and quit
let g:startify_enable_special = 0
