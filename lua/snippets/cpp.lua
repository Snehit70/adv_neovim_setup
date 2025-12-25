local ls = require("luasnip")
local s = ls.snippet
local t = ls.text_node
local i = ls.insert_node

return {
  -- Main boilerplate: type `!simple` and press Tab
  s("!simple", {
    t({ "#include <iostream>", "" }),
    t({ "using namespace std;", "" }),
    t({ "", "int main() {", "  " }),
    i(1, "// Your code here"),
    t({ "", "  return 0;", "}" }),
  }),

  -- Alternative without namespace
  s("!std", {
    t({ "#include <iostream>", "" }),
    t({ "", "int main() {", "  " }),
    i(1, "// Your code here"),
    t({ "", "  return 0;", "}" }),
  }),

  -- Competitive programming template
  s("!", {
    t({ "#include <bits/stdc++.h>", "" }),
    t({ "using namespace std;", "" }),
    t({ "", "int main() {", "  ios_base::sync_with_stdio(false);", "  cin.tie(NULL);", "  " }),
    i(1, "// Your code here"),
    t({ "", "  return 0;", "}" }),
  }),
}
