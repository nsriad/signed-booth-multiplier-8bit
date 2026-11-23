`timescale 1ns/1ns

// parallel array multiplier, combinational (the baseline)
// eight baugh-wooley and rows plus one constant row go into the csa tree
module array_core
(
	input logic [7:0] a, b, // multiplicand, multiplier
	output logic [15:0] p // product
);

logic [7:0] t0, t1, t2, t3, t4, t5, t6, t7; // and terms, tj = a & b[j]
logic [15:0] row0, row1, row2, row3, row4, row5, row6, row7, bwrow; // rows into the tree
logic [15:0] s, c; // tree output

assign t0 = a & {8{b[0]}};
assign t1 = a & {8{b[1]}};
assign t2 = a & {8{b[2]}};
assign t3 = a & {8{b[3]}};
assign t4 = a & {8{b[4]}};
assign t5 = a & {8{b[5]}};
assign t6 = a & {8{b[6]}};
assign t7 = a & {8{b[7]}};

// row j is shifted left by j
// terms with a negative weight are inverted: a[7]&b[j] in rows 0..6,
// and a[0..6]&b[7] in row 7 (a[7]&b[7] has a positive weight)
assign row0 = {8'b0, ~t0[7], t0[6:0]};
assign row1 = {7'b0, ~t1[7], t1[6:0], 1'b0};
assign row2 = {6'b0, ~t2[7], t2[6:0], 2'b0};
assign row3 = {5'b0, ~t3[7], t3[6:0], 3'b0};
assign row4 = {4'b0, ~t4[7], t4[6:0], 4'b0};
assign row5 = {3'b0, ~t5[7], t5[6:0], 5'b0};
assign row6 = {2'b0, ~t6[7], t6[6:0], 6'b0};
assign row7 = {1'b0, t7[7], ~t7[6:0], 7'b0};

// baugh-wooley constants for the inverted terms: a 1 in column 8 and in column 15
assign bwrow = 16'h8100;

csa_tree_array tree(row0, row1, row2, row3, row4, row5, row6, row7, bwrow, s, c);
cpa16 cpa(s, c, p);

endmodule
