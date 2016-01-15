" pave.vim - perforce functionality for vim
" Maintainer: Josh Petrie <http://joshpetrie.net>
" Version:    0.0

python << EOF
import vim

plugin_path = vim.eval("expand('<sfile>:h')")
if not plugin_path in sys.path:
  sys.path.insert(0, plugin_path)

import pave
EOF

let s:IgnoreChangedShellNotice = 0

function! pave#ShouldIgnoreChangedShell()
  return s:IgnoreChangedShellNotice
endfunction

function! pave#ResetIgnoreChangedShell()
  let s:IgnoreChangedShellNotice = 0
endfunction

function! pave#Open()
  let s:IgnoreChangedShellNotice = 1
  python pave.paveOpen(vim.eval("expand('%')"))
endfunction

function! pave#Revert()
  let s:IgnoreChangedShellNotice = 1
  python pave.paveRevert(vim.eval("expand('%')"))
endfunction

function! pave#Diff()
  python pave.paveDiff(vim.eval("expand('%')"))
endfunction
