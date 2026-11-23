# Results

Logs and reports copied here after each tool run. Each file is replaced when
the run is repeated, so this folder always holds the latest numbers.

| file | what it holds |
|---|---|
| `iverilog_sim.log` | Icarus Verilog run of both designs, a quick check before VCS |
| `booth_sim.log` | VCS run of the Booth design: 12 corner cases and 65,536 pairs, 0 errors |
| `booth_dc.log` | Design Compiler log of `booth_run-dc.tcl` |
| `booth_area.rpt` | cell area, total and per block |
| `booth_timing.rpt` | critical path, `rb_reg[1]` to `product_reg[15]` |
| `booth_power.rpt` | power estimate, total and per block |
| `booth_qor.rpt` | summary: levels of logic, slack, cell count, area |
| `dve_booth.png` | DVE waveform of the 12 corner cases, signed decimal |

The array design and the layout and power reports from IC Compiler and
PrimeTime will be added here with the same `booth_` and `array_` prefixes.
