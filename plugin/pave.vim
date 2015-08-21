" pave.vim - perforce functionality for vim
" Maintainer: Josh Petrie <http://joshpetrie.net>
" Version:    0.0

if exists("g:loaded_pave")
  finish
endif

let g:loaded_pave = 1

command! -nargs=0 PaveOpen :call pave#Open()
command! -nargs=0 PaveRevert :call pave#Revert()
command! -nargs=0 PaveDiff :call pave#Diff()
