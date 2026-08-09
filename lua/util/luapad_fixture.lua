-- Sample data used as globals inside nvim-luapad scratchpads.
return {
  dict = { one = 1, two = 2, three = '3', five = 'nan', four = nil },
  list = { 1, 'two', 3, 16, 'orange :)' },
  lnums = { 1513, 205, 9647, 135.0, 249.58, -369.4, 1035.135 },
  mixed = {
    'a',
    6,
    type = 'babinga',
    foo = function(txt)
      return ('foogy' .. txt) or 'foogy'
    end,
    bar = 'bar',
  },
  nest = {
    15,
    lvl = 1,
    cat = 'nested',
    val = 0,
    { 3, lvl = 2, val = 100, 'first one', { 'yes', ['a-b'] = false, cat = 'thingy', lvl = 3 } },
    cfg = { -1, 120, val = 4.169, lvl = 2 },
    { cat = { 'list', 'vals', lvl = 3 } },
  },
  nested = {
    tb1 = { win = true, lose = 'that sucks', 14, pct = 0.465479 },
    tb2 = { 4, 135, 93.845, src = 'nvim-luapad' },
    { 200, 201, 202, 203, 204 },
    'stringy',
    { 'table', 'of', 'strings' },
    tbl_of_strings = { stringOne = 'one', stringTwo = '2' },
  },
}
