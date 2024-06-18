# A Vivado script that demonstrates a very simple RTL-to-bitstream non-project batch flow
# USAGE: vivado -mode tcl -source bit.tcl -tclargs <TOP> <PART>

# Take in arguments
set TOP [lindex $argv 0]
set PART [lindex $argv 1]

# Create folder for reports 
file mkdir reports
file mkdir checkpoints

#
# STEP#1: setup design sources and constraints
#
read_verilog -sv [ glob rtl/*.sv ]
read_xdc [glob constraints/*.xdc]
#
# STEP#2: run synthesis, report utilization and timing estimates, write checkpoint design
#
synth_design -top $TOP -part $PART
write_checkpoint -force checkpoints/post_synth
report_timing_summary -file reports/post_synth_timing_summary.rpt
report_power -file reports/post_synth_power.rpt
#
# STEP#3: run placement and logic optimzation, report utilization and timing estimates, write checkpoint design
#
opt_design
place_design
phys_opt_design
write_checkpoint -force checkpoints/post_place
report_timing_summary -file reports/post_place_timing_summary.rpt
#
# STEP#4: run router, report actual utilization and timing, write checkpoint design, run drc, write verilog and xdc out
#
route_design
write_checkpoint -force checkpoints/post_route
report_timing_summary -file reports/post_route_timing_summary.rpt
report_timing -sort_by group -max_paths 100 -path_type summary -file reports/post_route_timing.rpt
report_clock_utilization -file reports/clock_util.rpt
report_utilization -file reports/post_route_util.rpt
report_power -file reports/post_route_power.rpt
report_drc -file reports/post_imp_drc.rpt

# write_verilog -force $TOP\_impl_netlist.v
# write_xdc -no_fixed_only -force $TOP\_impl.xdc

#
# STEP#5: generate a bitstream
# 
write_bitstream -force $TOP.bit
