`timescale 1ns/1ns

// one carry-save layer: a row of 3:2 compressors (full adders)
// three rows in, two rows out, so no carry ripples inside a layer
module csa32
(
	input logic [15:0] x, y, z, // three rows in
	output logic [15:0] s, // sum, stays in the same column
	output logic [15:0] c // carry, moves one column left
);

assign s = x ^ y ^ z;
assign c = ((x & y) | (x & z) | (y & z)) << 1;

endmodule
