`timescale 1ns/1ns

// radix-4 booth encoder for one group g = {b[2i+1], b[2i], b[2i-1]}
// digit d = -2*g[2] + g[1] + g[0]

module booth_encoder
(
	input logic [2:0] g, // one group of three bits
	output logic neg, // digit is negative
	output logic one, // use a
	output logic two // use 2a
);

assign neg = g[2] & ~(g[1] & g[0]);
assign one = g[1] ^ g[0];
assign two = (g[2] & ~g[1] & ~g[0]) | (~g[2] & g[1] & g[0]);

endmodule
