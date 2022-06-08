local parser_config = require "nvim-treesitter.parsers".get_parser_configs()
parser_config.hare = {
  install_info = {
    url = "https://git.sr.ht/~ecmma/tree-sitter-hare", -- local path or git repo
    files = {"src/parser.c"},
    -- optional entries:
    generate_requires_npm = false, -- if stand-alone parser without npm dependencies
    requires_generate_from_grammar = false, -- if folder contains pre-generated src/parser.c
  },
  filetype = "ha", -- if filetype does not match the parser name
}
