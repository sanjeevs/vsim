require 'minitest/autorun'
require 'vsim'

#
# Test utils
#
class TestUtils < Minitest::Test
    def test_abs_path
        assert_equal "/a/b/c", Vsim::Utils::create_abs_path("/a/b/c")
    end

    def test_ws_abs_path
        assert_equal " /a/b/c", Vsim::Utils::create_abs_path(" /a/b/c")
    end

    def test_rel_path
        assert_equal "/x/a/b/c", Vsim::Utils::create_abs_path("a/b/c", "/x")
    end

    def test_space_rel_path
        assert_equal "a/b/c", Vsim::Utils::create_abs_path("a/b/c")
    end

end
