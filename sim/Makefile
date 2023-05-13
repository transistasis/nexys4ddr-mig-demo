# Vivado Simulator Makefile
# Adapted from the original script by Norbertas Kremeris
# www.itsembedded.com

# Project Settings
TB_TOP := tb_nexys4ddr_mig_demo
SRC_F  := ../src/src.f
SIM_F  := ../sim/sim.f
IP_F   := ../ip/ip.f

# SystemVerilog
SOURCE_SV_FILES := $(shell grep -r "\\.svh\\?\\s*\$$" $(SRC_F))
SIM_SV_FILES    := $(shell grep -r "\\.svh\\?\\s*\$$" $(SIM_F))
IP_SV_FILES     := $(shell grep -r "\\.svh\\?\\s*\$$" $(IP_F))

SOURCES_SV := $(SOURCE_SV_FILES) $(SIM_SV_FILES) $(IP_SV_FILES)

COMP_OPTS_SV := \
    --incr \
#    --relax \

DEFINES_SV :=

# Verilog
SOURCE_V_FILES  := $(shell grep -r "\\.v\\s*\$$" $(SRC_F))
SIM_V_FILES     := $(shell grep -r "\\.v\\s*\$$" $(SIM_F))
IP_V_FILES      := $(shell grep -r "\\.v\\s*\$$" $(IP_F))

SOURCES_V := $(SOURCE_V_FILES) $(SIM_V_FILES) $(IP_V_FILES)

COMP_OPTS_V :=

DEFINES_V :=

# VHDL
SOURCE_VHDL_FILES  := $(shell grep -r "\\.vhd\\s*\$$" $(SRC_F))
SIM_VHDL_FILES     := $(shell grep -r "\\.vhd\\s*\$$" $(SIM_F))
IP_VHDL_FILES      := $(shell grep -r "\\.vhd\\s*\$$" $(IP_F))

SOURCES_VHDL := $(SOURCE_VHDL_FILES) $(SIM_VHDL_FILES) $(IP_VHDL_FILES)

COMP_OPTS_VHDL := \
    --incr \
    --relax \

# Testbench Configuration
SUB ?= SV
ifeq ($(SUB), VHDL)
  $(info Building with VHDL subtractor)
  DEFINES_SV := $(DEFINES_SV) -d SUBTRACTOR_VHDL
else ifeq ($(SUB), SV)
  $(info Building with SYSTEMVERILOG subtractor)
  DEFINES_SV := $(DEFINES_SV) -d SUBTRACTOR_SV
else
  $(info )
  $(info BAD SUBTRACTOR TYPE)
  $(info Available options:)
  $(info make SUB=VHDL <target>)
  $(info make SUB=SV <target>)
  $(error )
endif

# Elaboration Options
# 	e.g. ELAB_OPTS='-generic_top CLK_PERIOD=100 -generic_top MAX_DATA_WIDTH=18'
ELAB_OPTS ?=

#==== Default target - running simulation without drawing waveforms ====#
.PHONY : simulate
simulate : $(TB_TOP)_snapshot.wdb

.PHONY : elaborate
elaborate : .elab.timestamp

.PHONY : compile
compile : .comp_sv.timestamp .comp_v.timestamp .comp_vhdl.timestamp

#==== CODE COVERAGE ====#
.PHONY : coverage
coverage : xsim.codeCov/$(TB_TOP)_snapshot/xsim.CCInfo
	@echo
	@echo "### GENERATING CODE COVERAGE ###"
	xcrg -cc_db $(TB_TOP)_snapshot -cc_report xsim.cc_report -report_format text

#==== WAVEFORM DRAWING ====#
.PHONY : waves
waves : $(TB_TOP)_snapshot.wdb
	@echo
	@echo "### OPENING WAVES ###"
	xsim --gui $(TB_TOP)_snapshot.wdb

#==== SIMULATION ====#
$(TB_TOP)_snapshot.wdb : .elab.timestamp
	@echo
	@echo "### RUNNING SIMULATION ###"
	xsim $(TB_TOP)_snapshot -tclbatch xsim_cfg.tcl

#==== ELABORATION ====#
.elab.timestamp : .comp_sv.timestamp .comp_v.timestamp .comp_vhdl.timestamp
	@echo
	@echo "### ELABORATING ###"
	xelab -debug all -top $(TB_TOP) -snapshot $(TB_TOP)_snapshot $(ELAB_OPTS) -cc_type bcstf -L unisims_ver -L secureip work.glbl
	touch .elab.timestamp

#==== COMPILING SYSTEMVERILOG ====#
ifeq ($(strip $(SOURCES_SV)),)
.comp_sv.timestamp :
	@echo
	@echo "### NO SYSTEMVERILOG SOURCES GIVEN ###"
	@echo "### SKIPPED SYSTEMVERILOG COMPILATION ###"
    touch .comp_sv.timestamp
else
.comp_sv.timestamp : $(SOURCES_SV) .sub_$(SUB).timestamp
	@echo
	@echo "### COMPILING SYSTEMVERILOG ###"
	xvlog --sv $(COMP_OPTS_SV) $(DEFINES_SV) $(SOURCES_SV)
	touch .comp_sv.timestamp
endif

#==== COMPILING VERILOG ====#
ifeq ($(strip $(SOURCES_V)),)
.comp_v.timestamp :
	@echo
	@echo "### NO VERILOG SOURCES GIVEN ###"
	@echo "### SKIPPED VERILOG COMPILATION ###"
	touch .comp_v.timestamp
else
.comp_v.timestamp : $(SOURCES_V)
	@echo
	@echo "### COMPILING VERILOG ###"
	xvlog $(COMP_OPTS_V) $(DEFINES_V) $(SOURCES_V)
	touch .comp_v.timestamp
endif

#==== COMPILING VHDL ====#
ifeq ($(strip $(SOURCES_VHDL)),)
.comp_vhdl.timestamp :
	@echo
	@echo "### NO VHDL SOURCES GIVEN ###"
	@echo "### SKIPPED VHDL COMPILATION ###"
	touch .comp_vhdl.timestamp
else
.comp_vhdl.timestamp : $(SOURCES_VHDL)
	@echo
	@echo "### COMPILING VHDL ###"
	xvhdl $(COMP_OPTS_VHDL) $(SOURCES_VHDL)
	touch .comp_vhdl.timestamp
endif

.PHONY : clean
clean :
	rm -rf *.jou *.log *.pb *.wdb xsim.dir xsim.codeCov xsim.cc_report xsim.covdb .Xil *.str vcd2tb
	rm -rf .*.timestamp

#==== Subtractor type marker generation ===#
.sub_$(SUB).timestamp :
	@rm -rf .sub_*.timestamp
	@touch .sub_$(SUB).timestamp
