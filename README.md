# pave.vim

Pave provides Perforce functionality to Vim.

The goal of this plugin is not to simply wrap the command-line `p4` utility (as
vim's `!` command works perfectly well), nor is it to ape all of P4V's functions.
Rather, Pave aims to provide higher-level operations that would be useful
while using Vim to edit files in a Perforce depot.

For example, `p4 edit` and `p4 add` are handled together by `:PaveOpen`, which does
the right thing based on whether or not the file in question is already in the
depot.

This plugin is still very early in development and probably does not have all the
useful features you'd expect. Feel free to file bugs and feature requests.

## Installation

Install via your plugin manager or method of choice.

Pave does not provide mappings for its command by default, so it is recommended
that you map the plugin's commands in your `.vimrc`, for example:

    :nnoremap <leader>pe :PaveOpen<CR>
    :nnoremap <leader>pr :PaveRevert<CR>
