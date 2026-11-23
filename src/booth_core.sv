`timescale 1ns/1ns

// radix-4 booth multiplier, combinational
// four booth rows plus one row of correction bits go into the csa tree
module booth_core
(
	input logic [7:0] a, b, // multiplicand, multiplier
	output logic [15:0] p // product
);

logic [3:0] neg, one, two; // one set per booth digit
logic [8:0] pp0, pp1, pp2, pp3; // booth rows before the shift
logic [15:0] row0, row1, row2, row3, negrow; // rows into the tree
logic [15:0] s, c; // tree output

// groups {b[2i+1], b[2i], b[2i-1]} with b[-1] = 0
booth_encoder enc0({b[1], b[0], 1'b0}, neg[0], one[0], two[0]);
booth_encoder enc1(b[3:1], neg[1], one[1], two[1]);
booth_encoder enc2(b[5:3], neg[2], one[2], two[2]);
booth_encoder enc3(b[7:5], neg[3], one[3], two[3]);

booth_ppgen gen0(a, neg[0], one[0], two[0], pp0);
booth_ppgen gen1(a, neg[1], one[1], two[1], pp1);
booth_ppgen gen2(a, neg[2], one[2], two[2], pp2);
booth_ppgen gen3(a, neg[3], one[3], two[3], pp3);

// row i is sign-extended to 16 bits and shifted left by 2i
assign row0 = {{7{pp0[8]}}, pp0};
assign row1 = {{5{pp1[8]}}, pp1, 2'b00};
assign row2 = {{3{pp2[8]}}, pp2, 4'b0000};
assign row3 = {pp3[8], pp3, 6'b000000};

// a negative digit inverts its row, so add 1 in column 2i to finish the negation
assign negrow = {9'b0, neg[3], 1'b0, neg[2], 1'b0, neg[1], 1'b0, neg[0]};

csa_tree_booth tree(row0, row1, row2, row3, negrow, s, c);
cpa16 cpa(s, c, p);

endmodule
