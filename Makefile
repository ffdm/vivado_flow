TOP = test
PART = xc7a50tfgg484-2

LDLIBS = -lokFrontPanel
CXX = g++

.PHONY: rtl load clean run
load: load/load_bitstream.cpp
	$(CXX) $^ -o $@/load_bitstream $(LDLIBS)

run: rtl load
	./load/load_bitstream $(TOP).bit

rtl: $(TOP).bit
	
test.bit: 
	vivado -nojournal -nolog -mode batch -source tcl/bit.tcl -tclargs $(TOP) $(PART)   
	# Remove annoying file (keep for debugging)
	# rm -f clockInfo.txt

clean:   
	rm -f load/load_bitstream $(TOP).bit
	rm -rf reports checkpoints
