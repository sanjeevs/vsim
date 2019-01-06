# Introduction
The purpose of the 'vsim' utility is to generate all the information needed by the verilog simulator to compile the design. The result is written as a set of JSON files that can be used by other tools to actually write out the specific simulation script.

The input to the vsim utility is a "config" file prepared by the developer to specify all the first level dependencies of the component. The actual config file is a valid ruby source code so the developer can use the full expressibility of the language to specify this information.

Following are the variables that vsim extracts from the config file.

1. @vlog_defines: Verilog defines that must be defined in the simulation.
2. @vlog_files: List of all verilog files that are needed.
3. @vlog_inc_dirs: List of all include directories that must be included in the compile.
4. @vlog_lib_dirs: List of all the directory paths that is passed to -L option in simulator.
5. @vlog_libs: List all the libraries that are passed to the -l option in the simulator.
6. @vlog_lib_suffixes: List of all the filname suffix for libraries.
7. @ext_configs: List of other configuration files that this configuration depends on.

The utility traces through the dependencies (specified by ext_dependencies) in a depth first fashion and accumulates the value of all these variables starting from the leaf. It then writes out the value of all these variables in a JSON format by default.

