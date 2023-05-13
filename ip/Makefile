generate : ip_generation.tcl
	vivado -mode batch -source ip_generation.tcl

ip_generation.tcl :
	~/bin/generate_ip/generate_ip.py

PHONY : clean
clean :
	rm -f *.jou *.str *.log *.tcl *.f
	rm -rf .Xil
	cd ddr_mig   && make clean && cd ..
	cd pll       && make clean && cd ..