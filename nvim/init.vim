source $HOME/.config/nvim/vim-plug/plugins.vim

source $HOME/.config/nvim/general/settings.vim

" Choose themes by uncommenting/commenting:
" source $HOME/.config/nvim/themes/onedark.vim
" source $HOME/.config/nvim/themes/base16.vim
" source $HOME/.config/nvim/themes/gruvbox.vim
source $HOME/.config/nvim/themes/nightfox.vim
" source $HOME/.config/nvim/themes/deus.vim
" source $HOME/.config/nvim/themes/everforest.vim
" source $HOME/.config/nvim/themes/tokyonight.vim
" source $HOME/.config/nvim/themes/kanagawa.vim
" source $HOME/.config/nvim/themes/oceanic-next.vim
" source $HOME/.config/nvim/themes/catpuccin.vim
" End themes

source $HOME/.config/nvim/themes/airline.vim

source $HOME/.config/nvim/keys/mappings.vim

" Include all plugin config
for f in split(glob($HOME . "/.config/nvim/plug-config/*.vim"), '\n')
  exe 'source' f
endfor

lua require 'general'
