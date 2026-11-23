# Results

Logs and reports copied here after each tool run. Each file is replaced when
the run is repeated, so this folder always holds the latest numbers.

| file | how it is made |
|---|---|
| `iverilog_sim.log` | Icarus Verilog run of both designs, as a quick check before VCS |
| `booth_sim.log`, `array_sim.log` | VCS run, main README section 1 |
| `booth_dc.log`, `array_dc.log` | `dc_shell -f booth_run-dc.tcl` (or `array_`) in `build/dc-syn` |
| `booth_area.rpt`, `array_area.rpt` | `build/dc-syn/reports/` |
| `booth_timing.rpt`, `array_timing.rpt` | `build/dc-syn/reports/` |
| `booth_power.rpt`, `array_power.rpt` | `build/dc-syn/reports/` |

Layout and power reports from IC Compiler and PrimeTime go here too, with the
same `booth_` and `array_` prefixes.
