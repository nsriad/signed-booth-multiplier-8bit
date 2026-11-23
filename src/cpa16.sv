`timescale 1ns/1ns

// final 16-bit carry-propagate adder
// the carry-out is dropped because a signed 8x8 product always fits in 16 bits
module cpa16
(
	input logic [15:0] s, c, // sum and carry rows from the csa tree
	output logic [15:0] p // product
);

assign p = s + c;

endmodule
