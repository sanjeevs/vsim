# Simple minded utils
require 'pathname'

class Vsim::Utils
    def self.create_abs_path(filepath, curr_dir="")
        pn = Pathname.new(filepath)
        if pn.relative?
            pn = Pathname.new(curr_dir) + filepath
        end
        return pn.to_s
    end
end
