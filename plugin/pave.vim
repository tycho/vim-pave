" pave.vim - perforce functionality for vim
" Maintainer: Josh Petrie <http://joshpetrie.net>
" Version:    0.0

if exists("g:loaded_pave")
  finish
endif

let g:loaded_pave = 1

augroup pave_autocommands
autocmd!

" When a file is changed from outside vim (for example, if Perforce makes it
" writable), this autocommand will suppress the change notification if it came
" from Pave itself.
autocmd FileChangedShell *
      \ if pave#ShouldIgnoreChangedShell() == 1 |
      \   let v:fcs_choice = "" |
      \   call pave#ResetIgnoreChangedShell() |
      \ else |
      \   let v:fcs_choice = "ask" |
      \ endif

autocmd FileChangedRO * nested call pave#Open()
augroup end

command! -nargs=0 PaveOpen :call pave#Open()
command! -nargs=0 PaveRevert :call pave#Revert()
command! -nargs=0 PaveDiff :call pave#Diff()
