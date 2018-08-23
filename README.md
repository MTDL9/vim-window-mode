# Window Mode

Adds a new VIM mode that allows performing window operations (selecting,
moving, resizing...) quickly by removing the `<C-w>` prefix from all the window
mappings.

The Window mode is activated either by pressing `<C-w>m`, or by using the
command `:WindowMode`.
All following inputs will be interpreted as having the `<C-w>` prefix, so for
example if while in this mode you press `j` and then `K` the inputs VIM will
receive will be `<C-w>j` and `<C-w>K`.

Some keys perform special actions:
- `<ESC>` or `<C-c>` exit the Window Mode and return to Normal Mode
- `0` through `9` can be used, as in normal mode, to repeat commands


## Installation

### [VimPlug](https://github.com/junegunn/vim-plug)

Add `Plug 'mtdl9/vim-window-mode'` to your `~/.vimrc` and run `PlugInstall`.

### [Vundle](https://github.com/gmarik/Vundle.vim)

Add `Plugin 'mtdl9/vim-window-mode'` to your `~/.vimrc` and run `PluginInstall`.

### [Pathogen](https://github.com/tpope/vim-pathogen)

    $ git clone https://github.com/mtdl9/vim-window-mode ~/.vim/bundle/vim-window-mode

### Manual Install

Copy the contents of the `plugin` folder in its respective ~/.vim/\* counterpart.


## Configuration

This mode supports custom mappings after the `<C-w>` prefix, for example you
can define some additional mappings in your .vimrc for switching/deleting
buffers:

```viml
nnoremap <C-w>B :bnext<CR>
nnoremap <C-w>V :bprev<CR>
nnoremap <C-w>D :bdelete<CR>
```

