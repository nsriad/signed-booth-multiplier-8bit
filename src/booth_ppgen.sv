`timescale 1ns/1ns

// one booth partial product row, 9 bits so that 2a fits
// pp = ((one & a) | (two & 2a)) ^ neg
// a negative digit is finished by the correction bit added in booth_core
module booth_ppgen
(
	input logic [7:0] a, // multiplicand
	input logic neg, one, two, // from booth_encoder
	output logic [8:0] pp // partial product row, not shifted yet
);

logic [8:0] a1; // a, sign-extended to 9 bits
logic [8:0] a2; // 2a, a shifted left by one

assign a1 = {a[7], a};
assign a2 = {a, 1'b0};

assign pp = ((a1 & {9{one}}) | (a2 & {9{two}})) ^ {9{neg}};

endmodule
