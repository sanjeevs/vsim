Gem::Specification.new do |s|
    s.name = "vsim"
    s.version = "0.0.0"
    s.executables << 'vsim'
    s.date = "2018-12-02"
    s.summary = "Creates script for running verilog"
    s.description = "Parses hierarical configuration files to create all the arguments for running verilog sims"
    s.authors = ["sanjeev singh"]
    s.email = "snjvsingh123@gmail.com"
    s.files = ["lib/vsim.rb", "/lib/vsim/config.rb"]
    s.license = "MIT"
end
