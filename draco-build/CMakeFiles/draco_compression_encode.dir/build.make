# CMAKE generated file: DO NOT EDIT!
# Generated by "Unix Makefiles" Generator, CMake Version 3.19

# Delete rule output on recipe failure.
.DELETE_ON_ERROR:


#=============================================================================
# Special targets provided by cmake.

# Disable implicit rules so canonical targets will work.
.SUFFIXES:


# Disable VCS-based implicit rules.
% : %,v


# Disable VCS-based implicit rules.
% : RCS/%


# Disable VCS-based implicit rules.
% : RCS/%,v


# Disable VCS-based implicit rules.
% : SCCS/s.%


# Disable VCS-based implicit rules.
% : s.%


.SUFFIXES: .hpux_make_needs_suffix_list


# Command-line flag to silence nested $(MAKE).
$(VERBOSE)MAKESILENT = -s

#Suppress display of executed commands.
$(VERBOSE).SILENT:

# A target that is always out of date.
cmake_force:

.PHONY : cmake_force

#=============================================================================
# Set environment variables for the build.

# The shell in which to execute make rules.
SHELL = /bin/sh

# The CMake executable.
CMAKE_COMMAND = /usr/local/Cellar/cmake/3.19.1/bin/cmake

# The command to remove a file.
RM = /usr/local/Cellar/cmake/3.19.1/bin/cmake -E rm -f

# Escaping for special characters.
EQUALS = =

# The top-level source directory on which CMake was run.
CMAKE_SOURCE_DIR = /Users/camel/work/bszhct/demo-draco/draco

# The top-level build directory on which CMake was run.
CMAKE_BINARY_DIR = /Users/camel/work/bszhct/demo-draco/draco-build

# Include any dependencies generated for this target.
include CMakeFiles/draco_compression_encode.dir/depend.make

# Include the progress variables for this target.
include CMakeFiles/draco_compression_encode.dir/progress.make

# Include the compile flags for this target's objects.
include CMakeFiles/draco_compression_encode.dir/flags.make

CMakeFiles/draco_compression_encode.dir/src/draco/compression/encode.cc.o: CMakeFiles/draco_compression_encode.dir/flags.make
CMakeFiles/draco_compression_encode.dir/src/draco/compression/encode.cc.o: /Users/camel/work/bszhct/demo-draco/draco/src/draco/compression/encode.cc
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green --progress-dir=/Users/camel/work/bszhct/demo-draco/draco-build/CMakeFiles --progress-num=$(CMAKE_PROGRESS_1) "Building CXX object CMakeFiles/draco_compression_encode.dir/src/draco/compression/encode.cc.o"
	/Library/Developer/CommandLineTools/usr/bin/c++ $(CXX_DEFINES) $(CXX_INCLUDES) $(CXX_FLAGS) -o CMakeFiles/draco_compression_encode.dir/src/draco/compression/encode.cc.o -c /Users/camel/work/bszhct/demo-draco/draco/src/draco/compression/encode.cc

CMakeFiles/draco_compression_encode.dir/src/draco/compression/encode.cc.i: cmake_force
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green "Preprocessing CXX source to CMakeFiles/draco_compression_encode.dir/src/draco/compression/encode.cc.i"
	/Library/Developer/CommandLineTools/usr/bin/c++ $(CXX_DEFINES) $(CXX_INCLUDES) $(CXX_FLAGS) -E /Users/camel/work/bszhct/demo-draco/draco/src/draco/compression/encode.cc > CMakeFiles/draco_compression_encode.dir/src/draco/compression/encode.cc.i

CMakeFiles/draco_compression_encode.dir/src/draco/compression/encode.cc.s: cmake_force
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green "Compiling CXX source to assembly CMakeFiles/draco_compression_encode.dir/src/draco/compression/encode.cc.s"
	/Library/Developer/CommandLineTools/usr/bin/c++ $(CXX_DEFINES) $(CXX_INCLUDES) $(CXX_FLAGS) -S /Users/camel/work/bszhct/demo-draco/draco/src/draco/compression/encode.cc -o CMakeFiles/draco_compression_encode.dir/src/draco/compression/encode.cc.s

CMakeFiles/draco_compression_encode.dir/src/draco/compression/expert_encode.cc.o: CMakeFiles/draco_compression_encode.dir/flags.make
CMakeFiles/draco_compression_encode.dir/src/draco/compression/expert_encode.cc.o: /Users/camel/work/bszhct/demo-draco/draco/src/draco/compression/expert_encode.cc
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green --progress-dir=/Users/camel/work/bszhct/demo-draco/draco-build/CMakeFiles --progress-num=$(CMAKE_PROGRESS_2) "Building CXX object CMakeFiles/draco_compression_encode.dir/src/draco/compression/expert_encode.cc.o"
	/Library/Developer/CommandLineTools/usr/bin/c++ $(CXX_DEFINES) $(CXX_INCLUDES) $(CXX_FLAGS) -o CMakeFiles/draco_compression_encode.dir/src/draco/compression/expert_encode.cc.o -c /Users/camel/work/bszhct/demo-draco/draco/src/draco/compression/expert_encode.cc

CMakeFiles/draco_compression_encode.dir/src/draco/compression/expert_encode.cc.i: cmake_force
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green "Preprocessing CXX source to CMakeFiles/draco_compression_encode.dir/src/draco/compression/expert_encode.cc.i"
	/Library/Developer/CommandLineTools/usr/bin/c++ $(CXX_DEFINES) $(CXX_INCLUDES) $(CXX_FLAGS) -E /Users/camel/work/bszhct/demo-draco/draco/src/draco/compression/expert_encode.cc > CMakeFiles/draco_compression_encode.dir/src/draco/compression/expert_encode.cc.i

CMakeFiles/draco_compression_encode.dir/src/draco/compression/expert_encode.cc.s: cmake_force
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green "Compiling CXX source to assembly CMakeFiles/draco_compression_encode.dir/src/draco/compression/expert_encode.cc.s"
	/Library/Developer/CommandLineTools/usr/bin/c++ $(CXX_DEFINES) $(CXX_INCLUDES) $(CXX_FLAGS) -S /Users/camel/work/bszhct/demo-draco/draco/src/draco/compression/expert_encode.cc -o CMakeFiles/draco_compression_encode.dir/src/draco/compression/expert_encode.cc.s

draco_compression_encode: CMakeFiles/draco_compression_encode.dir/src/draco/compression/encode.cc.o
draco_compression_encode: CMakeFiles/draco_compression_encode.dir/src/draco/compression/expert_encode.cc.o
draco_compression_encode: CMakeFiles/draco_compression_encode.dir/build.make

.PHONY : draco_compression_encode

# Rule to build all files generated by this target.
CMakeFiles/draco_compression_encode.dir/build: draco_compression_encode

.PHONY : CMakeFiles/draco_compression_encode.dir/build

CMakeFiles/draco_compression_encode.dir/clean:
	$(CMAKE_COMMAND) -P CMakeFiles/draco_compression_encode.dir/cmake_clean.cmake
.PHONY : CMakeFiles/draco_compression_encode.dir/clean

CMakeFiles/draco_compression_encode.dir/depend:
	cd /Users/camel/work/bszhct/demo-draco/draco-build && $(CMAKE_COMMAND) -E cmake_depends "Unix Makefiles" /Users/camel/work/bszhct/demo-draco/draco /Users/camel/work/bszhct/demo-draco/draco /Users/camel/work/bszhct/demo-draco/draco-build /Users/camel/work/bszhct/demo-draco/draco-build /Users/camel/work/bszhct/demo-draco/draco-build/CMakeFiles/draco_compression_encode.dir/DependInfo.cmake --color=$(COLOR)
.PHONY : CMakeFiles/draco_compression_encode.dir/depend

