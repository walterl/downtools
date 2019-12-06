# LisToggle

Neovim plugin to toggle Markdown todo list items.

Repeatedly running `:LisToggle` (mapped to `<C-Space>` in Markdown files),
turns the line

```
  Lua in Neovim is easy.
```

into

```
  * Lua in Neovim is easy.
```

into

```
  * [ ] Lua in Neovim is easy.
```

into

```
  * [X] Lua in Neovim is easy.
```

It only supports `*`-bullets, and preserves indentation.

## Installation

I recommend [vim-plug](https://github.com/junegunn/vim-plug):

```
Plug 'walterl/listoggle'
```

## Configuration

Disable the `<C-Space>` mapping in Markdown files with
`let g:listoggle_disable_mapping = 1`.

## Background

This plugin was developed to explore writing Neovim plugins in Lua.

I quite like [VimWiki](https://github.com/vimwiki/vimwiki)'s todo list toggling
support. But I didn't want to use VimWiki for Markdown files, didn't want to
write it in VimL (or
[regexes](https://marcelfischer.eu/blog/2019/checkbox-regex/)), and also didn't
want to have any external dependencies.

## License

[MIT](./LICENSE.md)
