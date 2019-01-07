# Create the config object given a file name
# If the filename is repeated then the factory returns the original
# object.

class Vsim::ConfigFactory
    @@config_registry = {}
    def self.create(filepath, root_dir="")
        abs_path = Vsim::Utils::create_abs_path(filepath, root_dir)
        if not File.file?(abs_path)
            raise Errno::ENOENT, "Could not find config file at \'#{abs_path}\'"
        end
        if not @@config_registry.key?(abs_path)
            @@config_registry[abs_path] = Vsim::Config.new(File.read(abs_path))
        end
        return @@config_registry[abs_path]
    end
end
