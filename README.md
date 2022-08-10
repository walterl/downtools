# [mark]downtools

Neovim plugin containing some useful Markdown editing functionality:

* [Toggle task list item](#toggle-task-list-item)
* [Create a link from the visual selection](#create-a-link-from-the-visual-selection)
* [Bold the visual selection](#bold-the-visual-selection)

(This project used to be called _LisToggle_ when it only supported the first item.)

## Installation

I use and recommend [vim-plug](https://github.com/junegunn/vim-plug):

```
Plug 'walterl/downtools'
```

## Features
### Toggle task list item
Repeatedly running `:DownToggleListItem` (mapped to `<C-Space>` in Markdown
files), turns the line

    Lua in Neovim is easy.

into

    - Lua in Neovim is easy.

into

    - [ ] Lua in Neovim is easy.

into

    - [X] Lua in Neovim is easy.

and back into

    - [ ] Lua in Neovim is easy.

Indentation is preserved, and the list marker at the current indentation level
will be used, defaulting to `-`.

### Create a link from the visual selection
Visually selecting `bar` in a line containing `foo bar baz` and hitting
`<C-k>`, will change that line to:

    foo [bar]() baz

`<C-k>` just executes the `DownMakeLink` command.

The cursor will be placed between the parentheses (`()`).

### Bold the visual selection
Visually selecting `bar` and hitting `<C-b>` will change

    foo bar baz

into

    foo **bar** baz

## Configuration

Disable the `<C-Space>` mapping in Markdown files with
`let g:downtools_disable_list_toggle_mapping = 1`.

Disable the `<C-k>` mapping in Markdown files with
`let g:downtools_disable_vlink_mapping = 1`.

Disable the `<C-b>` mapping in Markdown files with
`let g:downtools_disable_bold_mapping = 1`.

## Background

This plugin was developed to explore writing Neovim plugins in Lua.

I quite like [VimWiki](https://github.com/vimwiki/vimwiki)'s todo list toggling
support, but I didn't want to use VimWiki for Markdown files, write a plugin
for that in VimL (or
[regexes](https://marcelfischer.eu/blog/2019/checkbox-regex/)), and didn't want
to have any external dependencies.

Using GitHub for pull requests, I noticed that it has a very useful shortcut
(Ctrl-k) for surrounding a selection in Markdown link dressing (it turns
selection `foo` into `[foo](url)`, with `url` selected). Growing tired of
manually creating such links, I implemented that in this plugin too. This is
the point where the project was renamed from _LisToggle_ to _downtools_.

## License

[MIT](./LICENSE.md)
