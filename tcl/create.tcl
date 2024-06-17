# USAGE: source create.tcl -tclargs TOP PART
# Where TOP is the name of your project and PART is the name of the board

set TOP [lindex $argv 0]
set PART [lindex $argv 1]

# Create design with part
link_design -part $PART

# Add SystemVerilog/Verilog files in rtl/ dir
if {[glob -nocomplain rtl/*.sv] != ""} {
  puts "Reading SystemVerilog Files..."
  read_verilog -sv [glob rtl/*.sv]
}
if {[glob -nocomplain rtl/*.v] != ""} {
  puts "Reading Verilog Files..."
  read_verilog [glob rtl/*.v]
}

# Synthesize design
puts "Synthesizing design..."
synth_design -top $TOP -flatten_hierarchy full

# Read constraint file
read_xdc $TOP.xdc

# Place design
puts "Placing design..."
place_design 

# Route design
puts "Routing design..."
route_design

# Write checkpoint
puts "Writing checkpoint"
write_checkpoint -force $TOP.dcp

# Write bitstream
puts "Writing bitstream"
write_bitstream -force $TOP.bit

