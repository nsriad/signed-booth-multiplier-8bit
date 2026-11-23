# Synthesis (Design Compiler)

Both scripts run the same steps and differ only in the source files they read.
Each script creates `reports/` and `output/` if they do not exist yet.

| script | design | difference |
|---|---|---|
| `booth_run-dc.tcl` | radix-4 Booth | reads the Booth sources |
| `array_run-dc.tcl` | array baseline | reads the array sources and uses `-define ARRAY` |

Run from this folder:

```
dc_shell -f booth_run-dc.tcl | tee booth_dc.log
dc_shell -f array_run-dc.tcl | tee array_dc.log
```

Files created:

```
reports/booth_area.rpt      area (also _timing, _power, _qor, _constraints,
                            _hierarchy, _resources, _reference)
output/booth_syn.sv         gate-level netlist
output/booth_syn.ddc        design database, for Formality and IC Compiler
output/booth_syn.sdc        constraints, for IC Compiler
booth_syn.svf               setup file for Formality
```

The array run writes the same files with `array_` instead of `booth_`.

The clock is `clk` with a 20 ns period.
