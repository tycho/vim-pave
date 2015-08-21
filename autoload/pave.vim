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

function! pave#Open()
  python pave.paveOpen(vim.eval("expand('%')"))
endfunction

function! pave#Revert()
  python pave.paveRevert(vim.eval("expand('%')"))
endfunction

function! pave#Diff()
  python pave.paveDiff(vim.eval("expand('%')"))
endfunction
