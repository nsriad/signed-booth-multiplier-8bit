`timescale 1ns/1ns

// reduction tree for the booth design: 5 rows to 2 in three layers
// 5 -> 4 -> 3 -> 2
module csa_tree_booth
(
	input logic [15:0] r0, r1, r2, r3, r4, // partial product rows
	output logic [15:0] s, c // two rows for the cpa
);

logic [15:0] s1, c1, s2, c2;

// layer 1: r0, r1, r2 (r3 and r4 wait)
csa32 l1(r0, r1, r2, s1, c1);

// layer 2: s1, c1, r3 (r4 waits)
csa32 l2(s1, c1, r3, s2, c2);

// layer 3: s2, c2, r4
csa32 l3(s2, c2, r4, s, c);

endmodule
