require 'minitest/autorun'
require 'vsim'

class VsimTest < Minitest::Test
    def test_hi
        assert_equal "hello world", Vsim.hi
    end
end
