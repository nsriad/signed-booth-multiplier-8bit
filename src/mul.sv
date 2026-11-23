`timescale 1ns/1ns

// top level of the signed 8x8 multiplier: Reg A, Reg B, the core, and Reg P
// the booth core is used by default; define ARRAY to build the array baseline
// (vcs: +define+ARRAY, design compiler: analyze -define ARRAY)
module mul
(
	input logic clk, rst_n, // clock, active-low reset
	input logic signed [7:0] a, b, // operands
	output logic signed [15:0] product // product, ready two clocks after a and b
);

logic [7:0] ra, rb; // Reg A, Reg B
logic [15:0] p; // core output

`ifdef ARRAY
	array_core core(ra, rb, p);
`else
	booth_core core(ra, rb, p);
`endif

always @(posedge clk, negedge rst_n)
begin
if (!rst_n)
	begin
		ra <= 'b0;
		rb <= 'b0;
		product <= 'b0;
	end
else
	begin
		ra <= a;
		rb <= b;
		product <= p;
	end
end

endmodule
