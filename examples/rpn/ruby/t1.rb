require 'rpn'
require 'test/unit'

class TestRpn < Test::Unit::TestCase

  NORMAL_TESTS = [
    [ '1 -2 -', 3 ],
    [ '1 2 +', 3 ],
    [ '-1 2 +', 1 ],
    [ '-1 2 +', 1 ],
    [ '1 2 -', -1 ],
    [ '1 2 + 3 -', 0 ],
    [ '1 2 - 3 -', -4 ],
    [ '1 2 +', 3 ],
    [ '1 2 - 3 -', -4 ],
    [ '1 2 - 5 +', 4 ],
    [ '1 2 - 5 + 2 -', 2 ],
    [ '1 1 1 1 1 2 + + + + +', 7 ],
    [ '1 -5 +', -4 ],
    [ '5 3 *', 15 ],
    [ '-2 -5 *', 10 ],
    [ '2 -5 *', -10 ],
    [ '6 4 /', 1 ],
    [ '0 1 /', 0 ],
    [ '1 0 *', 0 ],
    [ '00 1 +', 1 ],
    [ '1 00 -', 1 ],
    [ '00', 0 ],
    [ '-00', 0 ],
    [ '-0001', -1 ],
    [ '010', 10 ],
    [ '1 2 3 * +', 7 ],
    [ '999 888 -', 111 ],
    [ '3 4 * 2 3 * +', 18 ],
    [ '3 4 * 2 / 3 *', 18 ],
    [ '3 4 * 5 / 3 *', 6 ],
    [ '3 4 / 6 * 3 /', 0 ],
    [ '3 4 / 6 * 3 * 4 * 5 * 6 * 78 *', 0 ],
    [ '12 1 / 2 /', 6 ],
    [ '3 4 * 2 3 * /', 2 ],
    [ '4 2 3 1 1 + - * -', 2 ],
    [ '1 2 * 3 * 4 * 5 * 6 * 7 * 6 / 5 / 4 / 3 /', 14 ],
    [ '0 6 * -0 5 / + 1 + 00000 - -2 -', 3 ],
    [ '05 5 06 * 2 / + 7 -', 13 ],
    [ '999999 1000 / 67 * 56 80 * 8 * -', 31093 ],
    [ '1 2 * 3 * 3 2 * 1 * - 4 5 / + 5 4 / - 9 6 * 6 / 9 * +', 80 ],
    [ '9998999 1000 / 67 * 56 80 * 8000 * - 6666 6969 * + 4657 250 / 780 * 890 * -', -1210380 ],
    [ '2 3 *', 6 ],
    [ '5 4 +', 9 ],
    [ '  5 4 +  ', 9 ],
    [ '42', 42 ],
  ]

  EXCEPTION_TESTS = [
    [ '5 4 %',     "Invalid token:\"%\""    ],
    [ '5 +',       "Stack underflow"        ],
    [ '+',         "Stack underflow"        ],
    [ '5 4 + 42',  "Invalid stack:[9 42]"   ],
    [ '',          "Invalid stack:[]"       ],
    [ '1 2 z9',    "Invalid token:\"z9\""   ],
    [ '1 2 9z',    "Invalid token:\"9z\""   ],
    [ '1 2 z-9',   "Invalid token:\"z-9\""  ],
    [ '1 2 -9z',   "Invalid token:\"-9z\""  ],
    [ 'z9 42 +',   "Invalid token:\"z9\""   ],
    [ '9z 42 +',   "Invalid token:\"9z\""   ],
    [ 'z-9 42 +',  "Invalid token:\"z-9\""  ],
    [ '-9z 42 +',  "Invalid token:\"-9z\""  ],
    [ '-',         "Stack underflow"        ],
    [ '5 - +',     "Stack underflow"        ],
  ]

  def test_normal
    NORMAL_TESTS.each do |expr, val|
      assert_equal( val, Rpn.evaluate(expr) )
    end
  end

  def test_exception
    EXCEPTION_TESTS.each do |expr, estr|
      begin
        v = Rpn.evaluate(expr)
      rescue RuntimeError
        assert_equal( estr, $!.message )
      end
    end
  end

end
