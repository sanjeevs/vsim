# Config class provided by the user.
# Add some boiler plate code around the arg and evaluate it.

class Vsim::Config
    attr_reader :vlog_inc_dirs, :vlog_defines, :vlog_files
    attr_reader :vlog_lib_dirs, :vlog_libs, :vlog_lib_suffix
    attr_reader :ext_configs

    def get_binding
        binding
    end

    def initialize(code="")
        # Legal instance variables.
        @vlog_inc_dirs = []
        @vlog_defines = []
        @vlog_files = []
        @vlog_lib_dirs = []
        @vlog_libs = []
        @vlog_lib_suffixes = []
        @ext_configs = []
        legal_variables = instance_variables
        eval(code, get_binding, __FILE__, __LINE__)
        if legal_variables != instance_variables
            diff = instance_variables - legal_variables
            if diff.length == 1
                raise TypeError.new("Keyword #{diff[0].to_s} is not legal")
            else
                raise TypeError.new("Keywords #{diff} are not legal.")
            end
        end
    end
end
