# synthesis of the radix-4 booth design
# run from build/dc-syn: dc_shell -f booth_run-dc.tcl | tee booth_dc.log
file mkdir reports output
lappend search_path ../../src
define_design_lib WORK -path work
set link_library [list /apps/designlib/SAED90_EDK/SAED_EDK90nm/Digital_Standard_cell_Library/synopsys/models/saed90nm_max.db /apps/synopsys2017/cafe/SAED/SAED90_EDK/SAED_EDK90nm/Digital_Standard_cell_Library/synopsys/models/saed90nm_min.db /apps/synopsys2017/cafe/SAED/SAED90_EDK/SAED_EDK90nm/Digital_Standard_cell_Library/synopsys/models/saed90nm_typ.db]
set target_library [list /apps/designlib/SAED90_EDK/SAED_EDK90nm/Digital_Standard_cell_Library/synopsys/models/saed90nm_max.db]
set_svf "booth_syn.svf"
analyze -library WORK -format sverilog "csa32.sv cpa16.sv booth_encoder.sv booth_ppgen.sv csa_tree_booth.sv booth_core.sv mul.sv"
elaborate -architecture verilog -library WORK "mul"
link
create_clock clk -name ideal_clock1 -period 20
set_max_area 0
compile -map_effort medium -area_effort medium
check_design
set_svf -off
report_timing -transition_time -nets -attributes -nosplit > reports/booth_timing.rpt
report_area -nosplit -hierarchy > reports/booth_area.rpt
report_power -nosplit -hier > reports/booth_power.rpt
report_qor  > reports/booth_qor.rpt
report_constraints > reports/booth_constraints.rpt
report_hierarchy > reports/booth_hierarchy.rpt
report_resources > reports/booth_resources.rpt
report_reference > reports/booth_reference.rpt
change_names -rules verilog -hierarchy
write -format ddc -hierarchy -output output/booth_syn.ddc
write -f verilog -hierarchy -output output/booth_syn.sv
write_sdc -version 1.7 -nosplit output/booth_syn.sdc
quit
