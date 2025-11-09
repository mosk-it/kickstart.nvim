local ls = require 'luasnip'
local s = ls.snippet
local t = ls.text_node
local i = ls.insert_node

-- Example snippets
ls.add_snippets('lua', {
  s('req', { t "require '", i(1, 'module'), t "'" }),
})

ls.add_snippets('python', {
  s('main', { t 'if __name__ == "__main__":', t { '', '    ' }, i(1, 'pass') }),
})

ls.add_snippets('org', {
  s('src', {
    t '#+BEGIN_SRC ',
    i(1, 'lang'),
    t { '', '' },
    i(2, 'code'),
    t { '', '#+END_SRC' },
  }),
})

ls.add_snippets('javascript', {
  s('cl', { t 'console.log(', i(1, '%s'), t ')' }),
})

ls.add_snippets('typescript', {
  s('cl', { t 'console.log(', i(1, '%s'), t ')' }),
})
