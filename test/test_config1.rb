require 'minitest/autorun'
require 'vsim'

#
# Test simple minded config files.
# A config class is represented by a Vsim::Config object
# Check that the attributes of the class are set properly.
# Also check that mistyping in user code is reported as error
#
class TestConfig1 < Minitest::Test
    def setup
        # A correct config file
        @user_code1 = %$
            @vlog_inc_dirs = ["i1", "i2", 'i3']
            @vlog_libs = ["lib1", "lib2"]
         $
         # Another correct config file
         @user_code2 = %$
            @vlog_inc_dirs = ["i4", "i5", 'i6']
            @vlog_libs = ["lib3", "lib4"]
         $
         # A config file with a single typo
         @typo_code1 = %$
            @my_typo = []
        $
        # A config file with multipe typos
        @typo_code2 = %$
            @my_typo_1 = ['ab']
            @my_typo_2 = ['cd']
        $
        @valid_attributes = Set.new([:@vlog_defines, :@vlog_files, :@vlog_inc_dirs,
                                     :@vlog_lib_dirs, :@vlog_libs, :@vlog_lib_suffixes,
                                     :@ext_configs])

    end

    # Check the default value of attributes are empty list.
    def test_default_valid_attributes
        tmp = Vsim::Config.new()
        assert_equal @valid_attributes, Set.new(tmp.instance_variables)
    end

    def test_default_empty_values
        tmp = Vsim::Config.new()
        tmp.instance_variables.each do |attr|
            assert_equal [], tmp.instance_variable_get(attr)
        end
    end

    def test_single_typo
      exception = assert_raises TypeError do
          Vsim::Config.new(@typo_code1)
      end
      assert_equal "Keyword \'@my_typo\' is not legal", exception.message
    end

    def test_multiple_typos
      exception = assert_raises TypeError do
          Vsim::Config.new(@typo_code2)
      end
      assert_equal "Keywords \'@my_typo_1, @my_typo_2\' are not legal.", exception.message
    end

    def test_eval
        tmp1 = Vsim::Config.new(@user_code1)
        assert_equal 3, tmp1.vlog_inc_dirs.length
        assert_equal ["i1", "i2", "i3"], tmp1.vlog_inc_dirs
        assert_equal ["lib1", "lib2"], tmp1.vlog_libs
    end

    # Make sure that same string gives the same object
    def test_equality
        tmp1 = Vsim::Config.new(@user_code1)
        tmp2 = Vsim::Config.new(@user_code1)
        assert_equal tmp1.vlog_inc_dirs, tmp2.vlog_inc_dirs
    end

    # Make sure that values are not getting appended.
    def test_clean_state
        tmp1 = Vsim::Config.new(@user_code1)
        tmp1 = Vsim::Config.new(@user_code2)
        assert_equal ["lib3", "lib4"], tmp1.vlog_libs
    end

end
