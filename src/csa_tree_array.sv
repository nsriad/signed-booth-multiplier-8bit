`timescale 1ns/1ns

// reduction tree for the array baseline: 9 rows to 2 in four layers
// 9 -> 6 -> 4 -> 3 -> 2
module csa_tree_array
(
	input logic [15:0] r0, r1, r2, r3, r4, r5, r6, r7, r8, // partial product rows
	output logic [15:0] s, c // two rows for the cpa
);

logic [15:0] s1a, c1a, s1b, c1b, s1c, c1c; // after layer 1 (6 rows)
logic [15:0] s2a, c2a, s2b, c2b; // after layer 2 (4 rows)
logic [15:0] s3, c3; // after layer 3 (3 rows with c2b)

// layer 1: three groups of three
csa32 l1a(r0, r1, r2, s1a, c1a);
csa32 l1b(r3, r4, r5, s1b, c1b);
csa32 l1c(r6, r7, r8, s1c, c1c);

// layer 2: two groups of three
csa32 l2a(s1a, c1a, s1b, s2a, c2a);
csa32 l2b(c1b, s1c, c1c, s2b, c2b);

// layer 3: one group of three (c2b waits)
csa32 l3(s2a, c2a, s2b, s3, c3);

// layer 4
csa32 l4(s3, c3, c2b, s, c);

endmodule
