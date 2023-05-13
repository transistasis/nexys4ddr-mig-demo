##source "../ip/ceres_mcs.tcl"

# Change to the appropriate directory for Non-Project Mode
cd /home/ada/git_wa/nexys4ddr_mig_demo/build

# Since a project will not be created, it is important to specify a part
# This part will be used for any IP that is added to the design
# Otherwise, a default target part will be selected
set_part xc7a100tcsg324-1

# Only add_files, not import_files, can be used in Non-Project Mode
# The add_files command will call the appropriate lower-level command, which is read_verilog in this case
# The glob command creates a list out of the specified objects
read_verilog -sv [glob ../src/*.sv]

# Set the top-level module
set_property top nexys4ddr_mig_demo [current_fileset]

# Read IP
# read_ip -verbose ../ip/ceres_mcs/ceres_mcs.xci

# Import XDC files into the project that are used for top-level synthesis
read_xdc ./nexys4_ddr.xdc

# In Non-Project Mode, there are no design runs to launch, and no runs infrastructure managing the strategies
# used and the state of the design. These various stages need to be launched manually
synth_design -top nexys4ddr_mig_demo

# The Verilog files read in earlier in this script do not reference other files that are
# included using the `include statement. These would need to be added using the -include_dirs option.

# A DCP should be created after performing synthesis
write_checkpoint -force post_synth.dcp

# All post-synthesis reports should be generated now
report_timing_summary -file timing_syn.rpt

# Unlike in Project Mode, where there are no design runs that run multiple steps,
# they must all be specified here
# This allows certain steps to be skipped like logic optimization, power optimization, and physical synthesis
#   Logic optimization: opt_design
#   Placement: place_design
#   Physical synthesis: phys_opt_design
#   Routing: route_design
#   Bitstream generation: write_bitstream

# Implementation-specific constraints can be read in (to prevent collisions with Synthesis-specific constraints)
#read_xdc ../Lab_3_4_sources/Constraints/top_physical.xdc

# Manual optimization and placement design run commands can be specified
opt_design
place_design
write_checkpoint -force post_place.dcp
report_timing -file timing_place.rpt

# Manual synthesis and routing commands are specified
phys_opt_design
route_design
write_checkpoint -force post_route.dcp
report_timing_summary -file timing_summary.rpt

# After performing routing, a bitstream can be generated
write_bitstream -force nexys4ddr_mig_demo.bit
