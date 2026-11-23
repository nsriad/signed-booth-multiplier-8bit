`timescale 1ps/1ps

// self-checking testbench for the signed 8x8 multiplier
// part 1: 12 corner cases, printed and saved to mul.dump
// part 2: all 65,536 input pairs, compared with a * b
module mul_testbench();
	logic clk, rst_n; // clock, active-low reset
	logic signed [7:0] a, b; // operands
	logic signed [15:0] product; // result (output)
	logic signed [15:0] expected; // what product should be
	integer i, j; // loop counters
	integer errors; // number of wrong products

	mul mul_calc(clk, rst_n, a, b, product);

	// clk with a period of 20 ns
	always #10000 clk = ~clk;

	initial
		begin
`ifdef ARRAY
		$display("design: array baseline");
`else
		$display("design: radix-4 booth");
`endif
		clk = 1'b0;
		rst_n = 1'b0; // reset is active
		a = 8'd0;
		b = 8'd0;
		errors = 0;
		@(posedge clk);
		@(posedge clk);
		#2000;
		rst_n = 1'b1; // reset is inactive

		// part 1: corner cases
		for (i = 0; i < 12; i = i + 1)
		begin
			case (i)
				0: begin a = -128; b = -128; end // largest product
				1: begin a = -128; b = 127; end
				2: begin a = 127; b = 127; end
				3: begin a = 127; b = -128; end
				4: begin a = -1; b = -1; end
				5: begin a = -1; b = 1; end
				6: begin a = 1; b = -1; end
				7: begin a = 0; b = -128; end
				8: begin a = -128; b = 0; end
				9: begin a = 64; b = -2; end // booth digit -2
				10: begin a = -86; b = 85; end
				11: begin a = 85; b = -86; end
			endcase
			expected = a * b;
			@(posedge clk); // Reg A and Reg B load a and b
			@(posedge clk); // Reg P loads the product
			#2000;
			$display("a=%5d, b=%5d, product=%7d, expected=%7d", a, b, product, expected);
			if (product !== expected) errors = errors + 1;
		end

		// part 2: every input pair, no waveform (the file would be too large)
		$dumpoff;
		for (i = 0; i < 256; i = i + 1)
			for (j = 0; j < 256; j = j + 1)
			begin
				a = i[7:0];
				b = j[7:0];
				expected = a * b;
				@(posedge clk);
				@(posedge clk);
				#2000;
				if (product !== expected)
				begin
					errors = errors + 1;
					if (errors <= 10)
						$display("ERROR: a=%0d, b=%0d, product=%0d, expected=%0d", a, b, product, expected);
				end
			end

		$display("checked 12 corner cases and 65536 pairs, %0d errors", errors);
		if (errors == 0) $display("All tests completed successfully\n\n");
		else $display("TEST FAILED\n\n");
		$finish;
	end

	// to create a dump file for offline viewing
	initial
		begin
			$dumpfile ("mul.dump");
			$dumpvars (0, mul_testbench);
		end

endmodule
