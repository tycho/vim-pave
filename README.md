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

Install via [pathogen.vim](https://github.com/tpope/vim-pathogen):

    cd ~/.vim/bundle
    git clone git://github.com/jpetrie/vim-pave.git

Use Pathogen's `:Helptags` command to generate help, and then use `:help pave`
to view the manual. Pave does not provide mappings for its commands by default.
It is recommended that you map the plugin's commands in your `.vimrc`, for example:

    :nnoremap <leader>e :PaveOpen<CR>
