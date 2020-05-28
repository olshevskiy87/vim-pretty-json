# vim-pretty-json

Simple Vim plugin that beautifies JSON using [jq](https://stedolan.github.io/jq/).

## Installation

vim-plug:

```vim
Plug 'olshevskiy87/vim-pretty-json'
```

## Requirements

- Vim 8.0+
- command-line JSON processor [jq](https://stedolan.github.io/jq/).

## Usage

Use `<leader>jp` in normal mode to process current file or a several lines of json in visual mode.

## Global options

- `g:prettyjson_jq_options` specifies the `jq`'s CLI options (see `jq --help`)

## License

MIT. See file LICENSE for details.
