require 'minitest/autorun'
require 'vsim'

#
# Test config factory.
# Config factory is used to construct the config object
# given the file path. If the file path is reused then
# the previous config class is returned.
#
class TestConfigFactory < Minitest::Test
    def setup
        @path1 = "data/test1.config.rb"
        @path2 = "data/test2.config.rb"
    end

    def test_create
        cfg1 = Vsim::ConfigFactory::create(@path1, "./test")
        assert ["UVM_TESTNAME", "VERBOSITY=3"], cfg1.vlog_defines
    end

    def test_same_path
        cfg1 = Vsim::ConfigFactory::create(@path1, "./test")
        cfg2 = Vsim::ConfigFactory::create(@path1, "./test")
        assert_equal cfg1.object_id, cfg2.object_id
    end

    def test_unique_path
        cfg1 = Vsim::ConfigFactory::create(@path1, "./test")
        cfg2 = Vsim::ConfigFactory::create(@path2, "./test")
        assert ["UVM_TESTNAME", "VERBOSITY=3"], cfg1.vlog_defines
        assert_equal ["UVM_TESTNAME=test2", "VERBOSITY=3"], cfg2.vlog_defines
    end

end
